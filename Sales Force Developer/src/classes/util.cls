/*
util.cls
A collection of utility methods 
*/

public class util {

    /**
	* A utility method to reverse the order of sObjects within a list
	collection
	* @param input list<sObject> which contains the list of sObjects to
	reverse
	* @return list<sObject> which is a generic sObject typed collection of
	the reversed
	* list
	*/
    public static list<sObject> reverseSObjectList(list<sObject> input){
        list<sObject> temp = new list<sObject>();
        for (integer i = input.size()-1; i>=0; i--){
            temp.add(input[i]);
        }
    	return temp;
    }

    /**
	* twoDigitIntegerString
	* @description Returns a 2 digit string representation of integers by
	prepending 0 if under 10
	* @param integer input
	* @return string representation of input
	*/
	public static string twoDigitIntegerString(integer input){
		if (input < 10) {
			//if the input is less than 10, prepend a '0' and return
			return '0'+input;
		}
		//otherwise return the input as a string; implicit "else" clause
		return convertToIntegerString(input,2);
	}



	/**
	* convertToIntegerString
	* @description Returns string representation of integers prepended by 0s
	based on desired magnitude
	* @param integer input
	* @aparam integer magnitude
	* @return string reprepsentation of integer
	*/
	public static string convertToIntegerString(integer input, integer magnitude){
	//convert the integer to a string
	string returnvalue = string.valueOf(input);
		/* if the string is shorter than desired length / magnitude, prepend a 0
		until it is*/
		while (returnValue.length()<magnitude){
			returnValue = '0'+returnValue;
		}
		//return the formatted string
		return returnValue;
	}
}