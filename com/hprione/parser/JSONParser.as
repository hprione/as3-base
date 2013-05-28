package com.hprione.parser 
{
	import com.adobe.serialization.json.JSON;
	
	/**
	 * @author hprione
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
			var json:JSON = JSON.decode(data);
			
			return deserializeJSON(json);
		}
		
		protected function deserializeJSON(json:JSON):Object
		{
			return null;
		}
	}
}