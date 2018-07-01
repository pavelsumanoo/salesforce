public class RemoteController {
    @RemoteAction
    public static List<Potential__c> searchAccount(String name) {
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
						OR Name = 'Apple' )
}