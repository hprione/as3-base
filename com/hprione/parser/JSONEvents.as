package com.hprione.parser 
{
	import com.hprione.utils.ObjectUtils;
	import flash.events.Event;
	
	/**
	 * JSONEvents
	 * 
	 * @author hprione
	 * @since 15/11/2012
	 */
	public class JSONEvents extends Event 
	{
		public static const ON_COMPLETE:String = "onComplete";
		private var _data:Object;
		
		public function JSONEvents(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			
			_data = data;
		} 
		
		public override function clone():Event 
		{ 
			return new JSONEvents(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String
		{ 
			return formatToString("JSONEvents", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():Object { return _data; }
	}
}