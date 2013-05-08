package com.hprione.parser
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.System;
	
	/**
	 * XMLParser
	 * 
	 * @author hprione
	 * @since 02/04/2011
	 */
	[Event(name = "onData", type = "com.hprione.parser.XMLEvents")]
	public class XMLParser extends EventDispatcher
	{
		private var loader:URLLoader;
		protected var xml:XML;
		protected var items:Array;
		
		/**
		 * constructor
		 * 
		 * @param	url url of xml
		 * @param	vars attached variables
		 * @param	method sending method
		 */
		public function XMLParser(url:String, vars:URLVariables, method:String = "POST")
		{
			var request:URLRequest = new URLRequest(url);
			
			request.data = vars;
			request.method = method;
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.load(url);
		}
		
		/**
		 * Closes the load operation in progress.  Any load operation in progress is immediately terminated.
		 * If no URL is currently being streamed, an invalid stream error is thrown.
		 */
		public function close():void
		{
			try {
				loader.close();
			} catch (e:Error) {
				trace(e.message);
			}
			
			loader.removeEventListener(Event.COMPLETE, onCompleteHandler);
		}
		
		/**
		 * function called when the xml is loaded
		 * 
		 * @param	e
		 */
		protected function onCompleteHandler(e:Event):void
		{
			xml = XML(loader.data);
			items = new Array();
			
			close();
		}
		
		/**
		 * dispaches the data
		 */
		protected function dispatchData():void
		{
			System.disposeXML(_xml);
			
			dispatchEvent(new XMLEvents(XMLEvents.ON_DATA, items));
		}
	}
}