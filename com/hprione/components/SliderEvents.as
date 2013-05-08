package com.hprione.components
{
	import flash.events.Event;

	/**
	 * SliderEvents
	 * 
	 * @author hprione
	 * @since 09/06/2010
	 */
	
	public class SliderEvents extends Event
	{
		public static const ON_CHANGE:String = "onChange";
		private var _dragged:Boolean;
		
		public function SliderEvents (type:String, dragged:Boolean, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super (type, bubbles, cancelable);
			
			this.dragged = dragged;
		}

		public override function clone ():Event
		{
			return new SliderEvents (type, dragged, bubbles, cancelable);
		}

		public override function toString ():String
		{
			return formatToString ("SliderEvents", "dragged", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get dragged ():Boolean { return _dragged; }
		
		public function set dragged (value:Boolean):void
		{
			_dragged = value;
		}
	}
}