package com.hprione.components
{
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ToolTip
	 * 
	 * @author hprione
	 * @since 12/11/2010
	 */	
	public class ToolTip extends DisplayComponent 
	{
		private var _content:TextField;
		private var _delay:Number;
		private var _backgroundColor:uint;
		
		/**
		 * constructor
		 * 
		 * @param	text text displayed
		 * @param	style text's style
		 * @param	delay delay of movement - min = 0 max = 1
		 */
		public function ToolTip(text:String, style:TextFormat = null, delay:Number = .3)
		{
			super();
			
			_content = new TextField();
			_content.selectable = false;
			_content.mouseEnabled = false;
			_content.antiAliasType = AntiAliasType.ADVANCED;
			addChild(_content);
			
			this.setStyle(style);
			this.text = text;
			this.delay = delay;
			this.backgroundColor = 0xFFFF84;
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/**
		 * start the moviment of follow the mouse
		 */
		override protected function init():void 
		{
			super.init();
			
			followMouse();
		}
		
		/**
		 * stop the moviment of follow the mouse
		 * @param	e
		 */
		override protected function unloaded():void 
		{
			super.unloaded();
			
			unfollowMouse();
		}
		
		/**
		 * updates the user interface
		 */
		private function updateUI():void
		{
			_content.autoSize = TextFieldAutoSize.LEFT;
			_content.y = -_content.height;
			
			graphics.clear();
			graphics.beginFill(backgroundColor);
			graphics.drawRoundRect( _content.x - 1, _content.y - 1, _content.width + 2, _content.height + 2, 5, 5);
			graphics.endFill();
		}
		
		/**
		 * updates the position
		 * @param	e
		 */
		private function updatePos(e:Event):void
		{
			x +=(parent.mouseX - x) * _delay;
			y +=(parent.mouseY - y) * _delay;
		}
		
		/**
		 * follow the mouse
		 */
		private function followMouse():void
		{
			if(!hasEventListener(Event.ENTER_FRAME)) {
				addEventListener(Event.ENTER_FRAME, updatePos);
			}
		}
		
		/**
		 * unfollow the mouse
		 */
		private function unfollowMouse():void
		{
			if(hasEventListener(Event.ENTER_FRAME)) {
				removeEventListener(Event.ENTER_FRAME, updatePos);
			}	
		}
		
		/**
		 * text displayed
		 */
		public function get text():String
		{
			return _content.text;
		}
		
		public function set text(value:String):void
		{
			_content.text = value;
			updateUI();
		}
		
		/**
		 * delay of moviment - min = 0 max = 1, how much bigger, more faster
		 */
		public function get delay():Number { return _delay; }
		
		public function set delay(value:Number):void
		{
			if(value > 1) {
				value = 1;
			} else if(value < 0) {
				value = 0;
			}
				
			_delay = value;
		}
		
		public function get backgroundColor():uint { return _backgroundColor; }
		
		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
			updateUI();
		}
		
		/**
		 * style of displayed text, if null the style is Arial 10
		 * @param	style
		 */
		public function setStyle(style:TextFormat):void
		{
			if(style) {
				_content.defaultTextFormat = style;
			} else {
				_content.defaultTextFormat = new TextFormat("Arial", 10);
			}
			
			updateUI();
		}
	}
}