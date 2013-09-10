package com.hprione.form.validation
{
	import com.hprione.string.Validate;
	
	public class PhoneValidator extends GenericFormFieldValidator
	{
		public function PhoneValidator(message:String = null)
		{
			super(message || "This field it's not a valid phone");
		}
		
		override public function validate(value:String):Boolean
		{
			return Validate.isValidPhone(value);
		}
	}
}