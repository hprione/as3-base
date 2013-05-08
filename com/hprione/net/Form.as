package com.hprione.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * Form
	 * 
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
			this.request = new URLRequest(url);
			this.request.method = method;
			this.request.data = new URLVariables();
		}
		
		public function addParameter(parameter:String, value:String):void
		{
			request.data[parameter] = value;
		}
		
		public function load():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderErrorHandler);
			loader.load(request);
		}
		
		public function unload():void 
		{
			loader.removeEventListener(Event.COMPLETE, onLoaderCompleteHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderErrorHandler);
			loader = null;
		}
		
		private function onLoaderErrorHandler(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onLoaderCompleteHandler(e:Event):void 
		{
			_response = String(loader.data);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get response():String { return _response; }
	}
}