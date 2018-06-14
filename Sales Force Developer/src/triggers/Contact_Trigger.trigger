trigger Contact_Trigger on Contact (before insert, after insert) {
	//route before insert event to corresponding Contact_Methods method
	if(trigger.isBefore && trigger.isInsert){
		Contact_Methods.beforeInsert(trigger.new);
	}

	//route after insert event to corresponding Contact_Methods method
	if(trigger.isAfter && trigger.isInsert){
		Contact_Methods.afterInsert(trigger.new);	
	}
}