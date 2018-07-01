public with sharing class potential_Manager {
	//using Contact to hold selected Account
	//this allows the use of a lookup inputfield
	public Potential__c placeholderPotential {get;set;}
	public list<Potential__c> accountPotentials {get;set;}
	public list<Potential__c> accountPot {get;set;}
	
	public potential_Manager() {
		placeholderPotential = new Potential__c();
		accountPotentials = new list<Potential__c>();
		accountPot = new list<Potential__c>();
	}

	public void selectPotential(){
		//list<Potential__c> 
		accountPotentials  = [select product__c, 
		potential__c, 
		probability__c 
		From Potential__c];
	}

	@RemoteAction
	public static List<Potential__c> selectPot(String name) {
        name = name+'%';
		return [select product__c, 
		potential__c, 
		probability__c 
		From Potential__c];
	}

	@RemoteAction
	public static List<Account> selectPurchased(String name) {
    	name = name+'%';
    	return [ SELECT Name, NumberOfEmployees, BillingAddress, Industry, (SELECT FirstName,LastName FROM Contacts),  (SELECT Product__c FROM AccountPurchased__r) 
					FROM Account  
					WHERE NumberOfEmployees >10000 
					AND (Name ='AXA' OR Name = 'Exxon Mobil' 
						OR Name = 'General Electric' 
						OR Name = 'Apple' )];
    }
}