package com.hprione.parser
{
	
	/**
	 * @author hprione
	 * @since 02/04/2011
	 */
	public class XMLParser extends BaseParser
	{
		
		public function XMLParser(url:String, method:String = "POST")
		{
			super(url, method);
		}
		
		override protected function deserialize(data:String):Object 
		{
			var xml:XML = XML(data);
			
			return deserializeXML(xml);
		}
		
		protected function deserializeXML(xml:XML):Object
		{
			return null;
		}
	}
}