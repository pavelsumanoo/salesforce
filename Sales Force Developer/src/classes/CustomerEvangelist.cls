public with sharing class CustomerEvangelist{

    //using Contact to hold selected Account
	//this allows the use of a lookup inputfield
	public Contact placeholderContact {get;set;}
	public list<Contact> accountContacts {get;set;}
	public list<Account> accountAccount {get;set;}

	public CustomerEvangelist() {
			placeholderContact = new Contact();
			accountContacts = new list<Contact>();
			accountAccount  = new list<Account>();
	}


   @RemoteAction
	public static List<Account> selectPurchased(String name) {
    	name = name+'%';
    	return [ SELECT Name, NumberOfEmployees, BillingAddress, Industry, (SELECT FirstName,LastName FROM Contacts),  (SELECT Product__c FROM AccountPurchased__r) 
					FROM Account  
					WHERE NumberOfEmployees >10000 
					AND (Name ='AXA' OR Name = 'Exxon Mobil' 
						OR Name = 'General Electric' 
						OR Name = 'Apple' )
   // 	SELECT Name, 
			//(SELECT FirstName,LastName FROM Contacts), 
			//(SELECT Product__c FROM AccountPurchased__r) 
			//FROM Account  
			//WHERE NumberOfEmployees >10000 
			//LIMIT 4
			 ];
    }




	//select account by querying from placeholder value
	//remember to select fields on contacts to display
	public void selectAccount(){
		//refreshContacts();
	}


	//method to refresh selected Account Contact data
	public void refreshContacts(){
		//
	}

	
	/*although class variables can be placed anywhere in the class, it is best
	to place them all at the top of the class. This variable is shown here
	temporarily for illustrative purposes only*/
	public string actionContactId {get;set;}

}