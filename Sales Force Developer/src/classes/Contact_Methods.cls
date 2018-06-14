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
				//check if firstName is not blank before operating on it
				if (String.isNotBlank(c.firstName)){
					c.firstName = c.firstName.capitalize();
				}
				//check if lastName is not blank before operating on it
				if (String.isNotBlank(c.lastName)){
					c.lastName = c.lastName.capitalize();
				}
			}
		}

	/**
	* afterInsert
	* @description A static method for the Contact object containing
	* logic to be performed on the after insert event
	* @param newlist List collection of Contact records to execute logic on
	*/
	public static void afterInsert(list<Contact> newlist){
		//set collection of related accountIds from Contacts
		set<id> accountIds = new set<id>();
		for (Contact c : newlist){
			//if this Contact record has a related Account, store the Account's id
			if (c.accountId != null){
				accountIds.add(c.accountId);
			}
		}

		//perform aggregate query to count the number of Contacts for each account
		//affected by this trigger event
		//ContactCount will be the alias for the aggregate count of Contacts
		//This aggregate query will be grouped by the AccountId
		list<AggregateResult> accountContactsAggregate = [
			select accountId, count(id) ContactCount
			from Contact
			where accountId IN :accountIds
			group by accountId
		];

		//create a list collection of Accounts which will require updates
		list <Account> accountsToUpdate = new list<Account>();

		//for each aggregate result, representing an Account,
		//set the Number of Contacts field
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
}
