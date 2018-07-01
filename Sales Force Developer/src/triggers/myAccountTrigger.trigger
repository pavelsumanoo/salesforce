trigger myAccountTrigger on Account (before insert, after insert){
    if (trigger.isBefore && trigger.isInsert){
    	//before insert logic here
    }
    if (trigger.isAfter && trigger.isInsert){
    	//after insert logic here
    }
}