package com.hprione.parser
{
	import com.hprione.net.Form;
	import com.hprione.parser.ParserEvents;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLVariables;
	
	/**
	 * @author hprione
	 * @since 27/05/2013
	 */
	[Event(name = "onComplete", type = "com.hprione.parser.JSONEvents")]
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
	[Event(name = "onData", type = "com.hprione.parser.ParserEvents")]
	public class BaseParser extends EventDispatcher
	{
		private var form:Form;
		
		public function BaseParser(url:String, method:String = "POST")
		{
			form = new Form(url, method);
			form.addEventListener(Event.COMPLETE, onFormLoadCompleteEventHandler);
			form.addEventListener(IOErrorEvent.IO_ERROR, onFormIOErrorEventHandler);
		}
		
		public function addParameter(parameter:String, value:String):void
		{
			form.addParameter(parameter, value);
		}
		
		public function load():void
		{
			form.load();
		}
		
		public function unload():void
		{
			form.removeEventListener(Event.COMPLETE, onFormLoadCompleteEventHandler);
			form.removeEventListener(IOErrorEvent.IO_ERROR, onFormIOErrorEventHandler);
			form.unload();
			form = null;
		}
		
		private function onFormLoadCompleteEventHandler(e:Event):void 
		{
			dispatchEvent(new ParserEvents(ParserEvents.ON_DATA, deserialize(form.response)));
		}
		
		private function onFormIOErrorEventHandler(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		protected function deserialize(data:String):Object
		{
			return null;
		}
	}
}