/**
* contactWrapper
* @description class to contain a "selected" boolean matched to a specific
Contact record
*/
public class contactWrapper{
	public Contact wrappedContactRecord;
	public boolean selected = false;
	//simple constructor to assign the contact
	public contactWrapper(Contact inputContact){
		wrappedContactRecord = inputContact;
	}

	//constructor to assign contact and selected boolean
	public contactWrapper(Contact inputContact, boolean inputBoolean){
		wrappedContactRecord = inputContact;
		selected = inputBoolean;
	}

	//default empty constructor, instantiates with a new blank Contact
	public contactWrapper(){
		wrappedContactRecord = new Contact();
	}

	//mark this wrapper as selected
	public void select(){
		this.selected = true;
	}
	//mark this wrapper as deselected
	public void deselect(){
		this.selected = false;
	}
	// can you tell what this does?
	public void toggleSelectedState(){
		this.selected = (this.selected)?false:true;
	}
	
}