trigger Contact_Trigger on Contact (before insert, after insert, before update, after update) {
	//route before insert event to corresponding Contact_Methods method
	if(trigger.isBefore && trigger.isInsert){
		Contact_Methods.beforeInsert(trigger.new);
	}

	//route after insert and update events to corresponding Contact_Methods method
	if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
		Contact_Methods.afterUpsert(trigger.new);
	}

	//route before update event to corresponding Contact_Methods method
	if (trigger.isBefore && trigger.isUpdate){
		Contact_Methods.beforeUpdate(trigger.new, trigger.old);
	}
	//route after update event to corresponding Contact_Methods method
	if (trigger.isAfter && trigger.isUpdate){
		Contact_Methods.afterUpdate(trigger.new, trigger.old);
	}
}