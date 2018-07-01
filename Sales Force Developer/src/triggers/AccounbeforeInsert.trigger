/**
* Account_beforeInsert.trigger
* @description Contains logic for beforeInsert trigger on Account
*/
trigger AccounbeforeInsert on Account (before insert) {
    for (Account a : trigger.new) {
    /* if there is an account name specified before insert, make sure it is
    capitalized.*/
    if (a.name != null) 
        a.name = a.name.capitalize();
    }
}