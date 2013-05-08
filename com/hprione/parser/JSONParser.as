package com.hprione.parser 
{
	import com.adobe.serialization.json.JSON;
	import com.hprione.net.Form;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	/**
	 * JSONParser
	 * 
	 * @author hprione
	 * @since 15/11/2012
	 */
	[Event(name = "onComplete", type = "com.hprione.parser.JSONEvents")]
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
	public class JSONParser extends EventDispatcher
	{
		private var form:Form;
		
		public function JSONParser(url:String, method:String = "POST")
		{
			this.form = new Form(url, method);
		}
		
		public function addParameter(parameter:String, value:String):void
		{
			form.addParameter(parameter, value);
		}
		
		public function load():void
		{
			form.addEventListener(Event.COMPLETE, onLoaderCompleteHandler);
			form.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOErrorHandler);
			form.load();
		}
		
		private function onLoaderIOErrorHandler(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onLoaderCompleteHandler(e:Event):void 
		{
			var decoded:Object = JSON.decode(form.response);
			
			dispatchEvent(new JSONEvents(JSONEvents.ON_COMPLETE, deserialize(decoded)));
		}
		
		protected function deserialize(data:Object):Object
		{
			return data;
		}
		
		public function unload():void
		{
			form.removeEventListener(Event.COMPLETE, onLoaderCompleteHandler);
			form.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderIOErrorHandler);
			form.unload();
			form = null;
		}
	}
}