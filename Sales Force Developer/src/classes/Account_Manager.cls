public with sharing class Account_Manager{

    //using Contact to hold selected Account
	//this allows the use of a lookup inputfield
	public Contact placeholderContact {get;set;}
	public list<Contact> accountContacts {get;set;}

	public account_Manager() {
			placeholderContact = new Contact();
			accountContacts = new list<Contact>();
	}

	//select account by querying from placeholder value
	//remember to select fields on contacts to display
	public void selectAccount(){
		refreshContacts();
	}

	public void saveNewContact(){
		insert placeholderContact;
		//reset placeholder contact, but retain currently selected Account
		//when creating new sObjects, you can use constructor shorthand like this
		//to pass in variables to set fields and separating them with commas
		placeholderContact = new Contact(accountId = placeholderContact.accountid);
		//requery the Account contacts for selected Account
		refreshContacts();
	}
	//method to refresh selected Account Contact data
	public void refreshContacts(){
		// we only need the Account name for now
		placeholderContact.Account = [select id, Name
			from Account
			where id = :placeholderContact.accountid
		];

		accountContacts = [select id,
			firstname,
			lastname,
			phone,
			email
			from Contact
			where accountId = :placeholderContact.accountId
			order by firstname, lastname
		];
	}

	
	/*although class variables can be placed anywhere in the class, it is best
	to place them all at the top of the class. This variable is shown here
	temporarily for illustrative purposes only*/
	public string actionContactId {get;set;}
	public void deleteContact(){
	//perform the actual deletion.
	//All DML operations are exposed via the database class as methods
	//the delete method can take in an id or list of ids of records to delete
	/*here we are passing the id of the Contact assigned to the
	actionContactId variable*/
	database.delete(actionContactId);
	/*let us make use of the messages element to display a confirmation
	message on deletion*/
	//the syntax for this is quite long, see explanation in Chapter 7
	ApexPages.addMessage(
	new ApexPages.Message(
	ApexPages.Severity.CONFIRM,
	'Contact deleted successfully from account'
	+placeholderContact.account.name));
	//refresh the Contacts list to remove the deleted Contact
	refreshContacts();
	}

}