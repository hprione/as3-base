package com.hprione.parser 
{
	import com.adobe.serialization.json.JSON;

	/**
	 * @author hprione
	 * 
	 * @since 15/11/2012
	 */
	public class JSONParser extends BaseParser
	{
		
		public function JSONParser(url:String, method:String = "POST")
		{
			super(url, method);
		}
		
		override protected function deserialize(data:String):Object 
		{
			return deserializeJson(com.adobe.serialization.json.JSON.decode(data));
		}
		
		protected function deserializeJson(data:Object):Object
		{
			return null;
		}
	}
}