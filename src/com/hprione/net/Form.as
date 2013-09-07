package com.hprione.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * @author hprione
	 * @since 19/04/2011
	 */
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
	public class Form extends EventDispatcher
	{
		private var _response:String;
		
		private var loader:URLLoader;
		private var request:URLRequest;
		
		public function Form(url:String, method:String = "POST")
		{
			request = new URLRequest(url);
			request.method = method;
		}
		
		public function addParameter(parameter:String, value:String):void
		{
			if (!request.data) {
				request.data = new URLVariables();
			}
			
			request.data[parameter] = value;
		}
		
		public function send():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaderCompleteEventHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOErrorEventHandler);
			loader.load(request);
		}
		
		public function close():void 
		{
			try {
				loader.close();
			} catch (e:Error) {
				trace(e.message);
			}
		}
		
		public function unload():void 
		{
			close();
			
			loader.removeEventListener(Event.COMPLETE, onLoaderCompleteEventHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderIOErrorEventHandler);
			loader = null;
		}
		
		private function onLoaderIOErrorEventHandler(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onLoaderCompleteEventHandler(e:Event):void 
		{
			_response = String(loader.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get response():String { return _response; }
	}
}