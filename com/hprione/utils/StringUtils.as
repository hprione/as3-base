package com.hprione.utils
{
	
	/**
	 * StringUtils
	 * 
	 * @author Hugo Prione
	 * @since 13/12/2010
	 */
	public class StringUtils
	{
		
		/**
		 * returns the length of the text ignoring the white spaces
		 * 
		 * @param	text source text
		 * @return the length of the text ignoring the white spaces
		 */
		public static function realLength(text:String):int
		{
			return text.replace(/[\s|\r\n\r\n]/, "").length;
		}
		
		/**
		 * returns part of the text
		 * 
		 * @param	text source text
		 * @param	start initial position of the part of the text
		 * @param	len length of the text, in characters, from the initial position
		 * @return part of the text
		 */
		public static function mid(text:String, start:int, len:int):String
		{
			return text.substr(start, len);
		}
		
		/**
		 * returns part of the left of the text
		 * 
		 * @param	text source text
		 * @param	len length of the text, from left
		 * @return part of the left of the text
		 */
		public static function left(text:String, len:int):String
		{
			return mid(text, 0, len);
		}
		
		/**
		 * returns part of the right of the text
		 * 
		 * @param	text source text
		 * @param	len length of the text, from right
		 * @return part of the right of the text
		 */
		public static function right(text:String, len:int):String
		{
			return mid(text, text.length - len, len);
		}
		
		/**
		 * returns the text ignoring the white spaces from left
		 * 
		 * @param	text source text
		 * @return the text ignoring the white spaces from left
		 */
		public static function ltrim(text:String):String
		{
			return text.replace(/^\s+(.*)/, "$1");
		}
		
		/**
		 * returns the text ignoring the white spaces from right
		 * 
		 * @param	text source text
		 * @return the text ignoring the white spaces from right
		 */
		public static function rtrim(text:String):String
		{
			return text.replace(/(.*[^\s])\s*$/, "$1");
		}
		
		/**
		 * returns the text ignoring the white spaces from both sides
		 * 
		 * @param	text source text
		 * @return the text ignoring the white spaces from both sides
		 */
		public static function trim(text:String):String
		{
			return ltrim(rtrim(text));
		}
		
		/**
		 * returns the text in reverse order
		 * 
		 * @param	text source text
		 * @return the text in reverse order
		 */
		public static function reverse(text:String):String
		{
			return text.split("").reverse().join("");
		}
		
		/**
		 * returns the text formed with the amount of text informed
		 * 
		 * @param	string string source
		 * @param	times amount of string source
		 * @return the text formed with the amount of text informed
		 */
		public static function string(string:String, times:uint):String
		{
			var generated:String = new String();
			
			while (times--) {
				generated += string;
			}
			
			return generated;
		}
		
		/**
		 * returns the value in "000.000,00" format
		 * 
		 * @param source value source
		 * @param decimalPlaces number of decimal digits
		 * @return the value in "000.000,00" format
		 */
		public static function currency(source:Number, decimalPlaces:uint = 2):String
		{
			var negative:Boolean = source < 0;
			var fixed:String = Math.abs(source).toFixed(decimalPlaces);
			var splitted:Array = fixed.split(".");
			var value:String = splitted[0];
			var decimal:String = splitted[1];
			var valueFormated:String = new String();
			
			for (var i:int = value.length; i; i--) {
				if (!((value.length - i) % 3) && (value.length - i)) {
					valueFormated = "." + valueFormated;
				}
				
				valueFormated = value.charAt(i - 1) + valueFormated;
			}
			
			if (negative) {
				valueFormated = "-" + valueFormated;
			}
			
			return valueFormated + "," + decimal;
		}
		
		/**
		 * formats a string and replaces the %s with the correspondent args
		 * 
		 * @param	string the string that will be formatted
		 * @param	...args the args used to format the string
		 * @return the string formatted
		 * 
		 * @author Hugo Prione
		 * @since 11/02/2013 21:31
		 */
		public static function format(string:String, ...args):String
		{
			var matches:int = string.match(/%s/g).length;
			
			for (var i:int = 0; i < matches; i++) {
				string = string.replace(/%s/, args[i]);
			}
			
			return string;
		}
	}
}