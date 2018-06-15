/**
* Contact_Methods
* @description A collection of methods pertaining to the Contact object
*/
public with sharing class Contact_Methods {
		
	/**
		* beforeInsert
		* @description A static method for the Contact object containing
		* logic to be performed on the before insert event.
		* @param newlist List collection of Contact records to execute logic on
	*/
	public static void beforeInsert(list<Contact> newlist){
		//for every Contact record in the passed collection
		for (Contact c : newlist){
			formatContactName(c);
		}
	}

	/**
	* afterInsert
	* @description A static method for the Contact object containing
	* logic to be performed on the after insert event
	* @param newlist List collection of Contact records to execute logic on
	*/
	public static void afterInsert(list<Contact> newlist){
		//retrieve set of Account Ids for these Contacts and update Account Number
		// of Contacts field where applicable
		updateAccountNumberOfContacts(retrieveSetOfContactAccounts(newlist));
	}

	/**
	* formatContactName
	* @description Utility method for formatting a Contact's first and
	* last name to be uppercase
	* @param input A Contact record
	*/
	static void formatContactName(Contact input){
		//check if firstName is not blank before operating on it
		if (String.isNotBlank(input.firstName)){
			input.firstName = input.firstName.capitalize();
		}
		//check if lastName is not blank before operating on it
		if (String.isNotBlank(input.lastName)){
			input.lastName = input.lastName.capitalize();
		}
	}

	/**
	* retrieveSetOfContactAccounts
	* @description Utility method to retrieve a set of related Account ids
	* given a collection of Contacts
	* @param contacts List collection of Contact records to extract Account
	ids from
	*/
	public static set<id> retrieveSetOfContactAccounts(list<Contact> contacts){
		//set collection of related accountIds from Contacts
		set<id> accountIds = new set<id>();
		for (Contact c : contacts){
			//if this Contact record has a related Account, store the Account's id
			if (c.accountId != null){
				accountIds.add(c.accountId);
			}
		}
		//return set of Account Ids
		return accountIds;
	}


	/**
	* updateAccountNumberOfContacts
	* @description A static method used to update the Number of Contacts
	field for
	* related accounts determined by the passed in collection of Account Ids
	* @param accountIds Set collection of accountIds
	*/
	public static void updateAccountNumberOfContacts(set<id> accountIds){
		//perform aggregate query to count the number of Contacts for each account
		// affected by this trigger event
		// ContactCount will be the alias for the aggregate count of Contacts
		// This aggregate query will be grouped by the AccountId
		List<AggregateResult> accountContactsAggregate = [
							select accountId, count(id) ContactCount
							from Contact where accountId IN :accountIds 
							group by accountId];

		//create a list collection of Accounts which will require updates
		list<Account> accountsToUpdate = new list<Account>();
		
		/*for each aggregate result, representing an Account, set the Number of
		Contacts field*/
		for (AggregateResult ar : accountContactsAggregate){
			//create a representation of our Account with the given id
			Account currentAccount = new Account(id=string.valueOf(ar.get('accountId')));

			//set the Number of Contacts field from the aggregate result
			currentAccount.Number_of_Contacts__c = integer.valueOf(ar.get('ContactCount'));

			//add the account to the update collection
			accountsToUpdate.add(currentAccount);
		}
		//perform the database update of affected Accounts
		update accountsToUpdate;
	}

	/**
	* beforeUpdate
	* @description A static method for the Contact object containing
	* logic to be performed on the before update event.
	* @param newlist List collection of Contact records to execute logic on
	*/
	public static void beforeUpdate(list<Contact> newlist, list<Contact> oldList){
		//for every Contact record in the passed collection
		for (integer i=0; i <newlist.size(); i++){
			//if first or last name has changed only
			if (newList[i].firstName != oldList[i].firstName || newList[i].lastName != oldList[i].lastName){
				formatContactName(newlist[i]);
			}
		}
	}

	/**
	* afterUpdate
	* @description A static method for the Contact object containing
	* logic to be performed on the after update event
	* @param newlist List collection of Contact records to execute logic on
	*/
	public static void afterUpdate(list<Contact> newlist, list<Contact> oldList){
		//retrieve set of Account Ids for these Contacts and update Account
		// Number of Contacts field where applicable
		updateAccountNumberOfContacts(retrieveSetOfContactAccounts(newlist));
		updateAccountNumberOfContacts(retrieveSetOfContactAccounts(oldlist));
	}
}
