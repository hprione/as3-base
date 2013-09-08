package com.hprione.form.validation
{
	public class GenericFormFieldValidator
	{
		public var message:String;
		
		public function GenericFormFieldValidator(message:String)
		{
			this.message = message;
		}
		
		public function validate(value:String):Boolean
		{
			return false;
		}
	}
}