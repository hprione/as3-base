package com.hprione.utils
{
	
	/**
	 * ObjectUtils
	 * 
	 * @author hprione
	 * @since 11/02/2013
	 */
	public class ObjectUtils
	{
		
		public static function clone(obj:Object):Object
		{
			var c:Object = new Object();
			
			for (var p:String in obj) {
				c[p] = obj[p];
			}
			
			return c;
		}
	}
}