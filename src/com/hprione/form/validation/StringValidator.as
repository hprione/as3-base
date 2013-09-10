package com.hprione.form.validation
{
	import com.hprione.string.Validate;
	
	public class StringValidator extends GenericFormFieldValidator
	{
		public function StringValidator(message:String = null)
		{
			super(message || "This field can't be blank");
		}
		
		override public function validate(value:String):Boolean
		{
			return !Validate.isEmpty(value);
		}
	}
}