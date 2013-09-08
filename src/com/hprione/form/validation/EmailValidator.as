package com.hprione.form.validation
{
	import com.hprione.string.Validate;
	
	public class EmailValidator extends GenericFormFieldValidator
	{
		public function EmailValidator(message:String)
		{
			super(message || "This field it's not a valid email");
		}
		
		override public function validate(value:String):Boolean
		{
			return Validate.isValidEmail(value);
		}
	}
}