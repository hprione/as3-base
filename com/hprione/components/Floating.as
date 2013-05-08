package com.hprione.components
{
	import com.hprione.utils.Position;
	import flash.events.Event;
	
	/**
	 * Floating
	 * 
	 * @author hprione
	 * @since 23/11/2010
	 */
	public class Floating extends DisplayComponent 
	{
		private var speed:Number;
		private var index:Number;
		private var phase:Number;
		private var radius:Position;
		private var frequency:Position;
		private var position:Position;
		
		public function Floating(speed:Number = .06, radius:Number = 8)
		{
			super();
			
			this.speed = speed;
			this.index = 0;
			this.phase = Math.random () * (2 * Math.PI);
			this.radius = new Position(radius, radius);
			this.frequency = new Position(getRandomFrequency(), getRandomFrequency());
			this.position = new Position(x, y);
		}
		
		private function getRandomFrequency():Number
		{
			return (1 + (Math.random () * 3)) / 2;
		}
		
		override protected function init():void 
		{
			super.init();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void 
		{
			x = position.x + Math.cos(index * frequency.x + phase) * radius.x;
			y = position.y + Math.sin(index * frequency.y + phase) * radius.y;
			
			index += speed;
		}
		
		override protected function unloaded():void 
		{
			super.unloaded();
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		public function get positionX():Number 
		{
			return position.x;
		}
		
		public function set positionX(value:Number):void
		{
			position.x = value;
		}
		
		public function get positionY():Number
		{
			return position.y;
		}
		
		public function set positionY(value:Number):void
		{
			position.y = value;
		}
	}
}