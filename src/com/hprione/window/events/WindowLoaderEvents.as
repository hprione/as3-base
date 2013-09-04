package com.hprione.window.events
{
	import flash.events.Event;
	
	/**
	 * WindowLoaderEvents
	 * @author hprione
	 * @date 17/03/2011 15:59
	 */	
	public class WindowLoaderEvents extends Event 
	{
		static public const LOAD_WINDOW:String = "loadWindow";
		static public const WINDOW_LOADED:String = "windowLoaded";
		static public const WINDOW_UNLOADED:String = "windowUnloaded";
		static public const WINDOW_UNLOADING:String = "windowUnloading";
		public var window:Class;
		public var data:*;
		public var isPopup:Boolean;
		
		public function WindowLoaderEvents(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event
		{ 
			var e:WindowLoaderEvents = new WindowLoaderEvents(type, bubbles, cancelable);
			
			e.window = window;
			e.data = data;
			e.isPopup = isPopup;
			
			return e;
		} 
		
		public override function toString():String
		{ 
			return formatToString("WindowLoaderEvents", "window", "data", "isPopup", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}