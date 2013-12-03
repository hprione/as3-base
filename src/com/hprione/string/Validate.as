package com.hprione.string
{

	import com.hprione.utils.StringUtils;
	
	/**
	* Validate
	* @author Hugo Prione
	*/
	public class Validate
	{
		
		/**
		 * verify if the email is valid
		 * @param	email input email
		 * @return if the email is valid
		 */
		public static function isValidEmail(email:String):Boolean
		{
			var regex:RegExp =/^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			
			return regex.test(email);
		}
		
		/**
		 * verify if the cpf is valid
		 * @param	cpf input cpf
		 * @return if the cpf is valid
		 */
		public static function isValidCPF(cpf:String):Boolean
		{
			var regex:RegExp =/(\d{3})\.*(\d{3})\.*(\d{3})-*(\d{2})$/;
			var digits:String; 
			var index:int;
			var sum:int;
			var mod:int;
			
			if (!regex.test(cpf)) {
				return false;
			}
				
			digits = cpf.replace(regex, "$1$2$3");
			
			if (hasSameDigits(digits)) {
				return false;
			}
			
			index = 11;
			sum = 0;

			while(--index >= 2) {
				sum +=(index * int(digits.substr(10 - index, 1)));
			}

			mod = sum % 11;
			digits += mod < 2 ? "0" : String(11 -(mod));
			index = 12
			sum = 0;

			while(--index >= 2) {
				sum +=(index * int(digits.substr(11 - index, 1)));
			}

			mod = sum % 11;
			digits += mod < 2 ? "0" : String(11 -(mod));
			
			return cpf.replace(regex, "$1$2$3$4") == digits;
		}
		
		private static function hasSameDigits(digits:String):Boolean
		{
			var digit:String = digits.charAt(0);
			
			for(var i:int = 1; i < digits.length; i++) {
				if (digit != digits.charAt(i)) {
					return false;
				}
			}
			
			return true;
		}
		
		/**
		 * verify if the format of cnpj is valid
		 * @param	cnpj input cnpj
		 * @return if the format of cnpj is valid
		 */
		public static function isValidCNPJ(cnpj:String):Boolean
		{
			var regex:RegExp =/\d{2}\.*\d{3}\.*\d{3}\/*\d{4}-*\d{2}$/
			
			return regex.test(cnpj);
		}
		
		/**
		 * verify if the format of phone is valid
		 * @param	phone input phone
		 * @return if the format of phone is valid
		 */
		public static function isValidPhone(phone:String):Boolean
		{
			var regex:RegExp =/[\(\s{1}]*\d{2}[\)\s]*\d{4}[-\s]*\d{4}$/;
			
			return regex.test(phone);
		}
		
		/**
		 * verify if the format of date is valid
		 * @param	date input date
		 * @return if format of date is valid
		 */
		public static function isDate(date:String):Boolean
		{
			var regex:RegExp =/\d{1,2}([\/-])\d{1,2}\1\d{2,4}$/;
			
			return regex.test(date);
		}
		
		/**
		 * verify if the format of cep is valid
		 * @param	cep input cep
		 * @return if format of cep is valid
		 */
		public static function isCEP(cep:String):Boolean
		{
			var regex:RegExp =/\d{5}-*\d{3}$/
			
			return regex.test(cep);
		}
		
		/**
		 * verify if text is empty
		 * @param	text input text
		 * @param	ignoreWhiteSpace if the white spaces will be ignored
		 * @return
		 */
		public static function isEmpty(text:String, ignoreWhiteSpace:Boolean = true):Boolean
		{
			return ignoreWhiteSpace ? !Boolean(StringUtils.realLength(text)) : !Boolean(text.length);
		}
	}
}