package com.hprione.components
{
	
	import com.greensock.easing.Sine;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	[Event (name = "onChange", type = "com.hprione.components.slider.SliderEvents")];
	
	/**
	 * Slider
	 * 
	 * @author hprione
	 * @since 09/06/2010
	 */	
	public class Slider extends Sprite
	{
		private var _area:Rectangle;
		private var _smooth:Boolean;
		
		/**
		 * constructor
		 * @param	area draggable area
		 * @param	smooth if scroll moves smoothly
		 */		
		public function Slider (area:Rectangle = null, smooth:Boolean = true)
		{
			buttonMode = true;
			
			this.area = area;
			this.smooth = smooth;
		}
		
		/**
		 * draggable area
		 */		
		public function get area ():Rectangle { return _area; }
		
		public function set area (value:Rectangle):void
		{
			_area = value;
			
			if (area)
			{
				if (!hasEventListener (MouseEvent.MOUSE_DOWN))
					addEventListener (MouseEvent.MOUSE_DOWN, drag);
				if (!hasEventListener (MouseEvent.MOUSE_UP))
					addEventListener (MouseEvent.MOUSE_UP, drop);
			}
			else
			{
				if (hasEventListener (MouseEvent.MOUSE_DOWN))
					removeEventListener (MouseEvent.MOUSE_DOWN, drag);
				if (hasEventListener (MouseEvent.MOUSE_UP))
					removeEventListener (MouseEvent.MOUSE_UP, drop);
			}
		}
		
		/**
		 * horizontal percentage of scroll
		 */		
		public function get percentX ():Number
		{
			if (!area)
				return -1;
			return (x - area.left) / (area.right - area.left);
		}
		
		public function set percentX (value:Number):void
		{
			if (value > 1)
				value = 1;
			else if (value < 0)
				value = 0;
				
			if (smooth)
			{
				TweenLite.killTweensOf (this);
				TweenLite.to (this, .5, { x:area.left + (value * (area.right - area.left)), ease:Sine.easeOut } );
			}
			else
				x = area.left + (value * (area.right - area.left));
		}
		
		/**
		 * vertical percentage of scroll
		 */		
		public function get percentY ():Number
		{
			if (!area)
				return -1;
			return (y - area.top) / (area.bottom - area.top);
		}
		
		public function set percentY (value:Number):void
		{
			if (value > 1)
				value = 1;
			else if (value < 0)
				value = 0;
				
			if (smooth)
			{
				TweenLite.killTweensOf (this);
				TweenLite.to (this, .5, { y:area.top + (value * (area.bottom - area.top)) } );
			}
			else
				y = area.top + (value * (area.bottom - area.top));
		}
		
		override public function set x (value:Number):void
		{
			super.x = value;
			dispatchEvent (new SliderEvents (SliderEvents.ON_CHANGE, false));
		}
		
		override public function set y (value:Number):void
		{
			super.y = value;
			dispatchEvent (new SliderEvents (SliderEvents.ON_CHANGE, false));
		}
		
		/**
		 * if scroll moves smoothly
		 */		
		public function get smooth ():Boolean { return _smooth; }
		
		public function set smooth (value:Boolean):void
		{
			_smooth = value;
		}
		
		/**
		 * start drag and add event listeners
		 * @param	e
		 */		
		private function drag (e:MouseEvent):void
		{
			startDrag (false, area);
			
			addEventListener (Event.ENTER_FRAME, dispatchChange);
			stage.addEventListener (MouseEvent.MOUSE_UP, drop);
		}
		
		/**
		 * stop drag and remove event listeners
		 * @param	e
		 */		
		private function drop (e:MouseEvent = null):void
		{
			stopDrag ();
			
			removeEventListener (Event.ENTER_FRAME, dispatchChange);
			stage.removeEventListener (MouseEvent.MOUSE_UP, drop);
		}
		
		/**
		 * refresh the scroll position
		 * @param	e
		 */		
		private function dispatchChange (e:Event):void
		{
			dispatchEvent (new SliderEvents (SliderEvents.ON_CHANGE, true));
		}
		
		/**
		 * unloads this component
		 */
		public function unload ():void
		{
			drop ();
			
			area = null;
		}
	}
}