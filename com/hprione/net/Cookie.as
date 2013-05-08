package com.hprione.net
{
	import flash.net.SharedObject;
	
	/**
	* Cookie
	* 
	* @author Hugo Prione
	* @since 29/10/2009
	*/
	public class Cookie
	{
		private var sharedObject:SharedObject;
		
		/**
		 * constructor
		 * 
		 * @param	local local of SharedObject
		 */
		public function Cookie(local:String)
		{
			sharedObject = SharedObject.getLocal(local);
		}
		
		/**
		 * get the stored value in SharedObject
		 * 
		 * @param	key access key of value
		 * @param	defaultValue value returned if the key is empty
		 * @return returns the key if not is empty or default value
		 */
		public function getValue(key:String, defaultValue:String = null):String
		{
			var value:String = sharedObject.data[key];
			
			return value ? value : defaultValue;
		}
		
		/**
		 * stores the value in the given key
		 * 
		 * @param	key key where the value will stored
		 * @param	value value that will stored in the given key
		 */
		public function setValue(key:String, value:String):void
		{
			sharedObject.data[key] = value;
			sharedObject.flush();
		}
		
		/**
		 * purges all of the data and deletes the shared object from the disk.
		 */
		public function clear():void
		{
			sharedObject.clear();
		}
	}
}