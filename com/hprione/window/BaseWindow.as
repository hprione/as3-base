package com.hprione.window
{
	import com.hprione.components.DisplayComponent;
	import com.hprione.window.events.WindowLoaderEvents;
	import flash.events.Event;
	
	/**
	 * BaseWindow
	 * @author hprione
	 * @date 17/03/2011 15:51
	 */	
	[Event(name = "unload", type = "flash.events.Event")];
	[Event(name = "complete", type = "flash.events.Event")];
	[Event(name = "loadWindow", type = "com.hprione.window.events.WindowLoaderEvents")];
	public class BaseWindow extends DisplayComponent
	{
		public var isPopup:Boolean;
		
		/**
		 * constructor
		 */
		public function BaseWindow()
		{
			super();
		}
		
		/**
		 * this function is called when the unload is complete
		 */
		protected function unloadComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
			dispatchEvent(new Event(Event.UNLOAD));
		}
		
		/**
		 * unloads this class
		 */
		public function unload():void
		{
			unloadComplete();
		}
		
		public function setData(data:*):void
		{
		}
		
		/**
		 * dispatches an event that tells the LoaderWindow load a new window
		 * @param	window the window that will be loaded by the LoaderWindow
		 */
		protected function loadWindow(window:Class, data:* = null, isPopup:Boolean = false):void
		{
			var e:WindowLoaderEvents = new WindowLoaderEvents(WindowLoaderEvents.LOAD_WINDOW);
			
			e.window = window;
			e.data = data;
			e.isPopup = isPopup;
			
			dispatchEvent(e);
		}
	}
}