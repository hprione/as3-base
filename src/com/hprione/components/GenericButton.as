package com.hprione.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * GenericButton
	 * 
	 * @author Hugo Prione
	 * @since 18/03/2011
	 */
	public class GenericButton extends DisplayComponent
	{
		
		public function GenericButton():void
		{
			super();
			
			buttonMode = true;
			mouseChildren = false;
		}
		
		override protected function init():void 
		{
			super.init();
			
			addEventListener(MouseEvent.CLICK, onClickHandler);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
		}
		
		protected function onClickHandler(e:MouseEvent):void 
		{
		}
		
		protected function onMouseOverHandler(e:MouseEvent):void 
		{
		}
		
		protected function onMouseOutHandler(e:MouseEvent):void 
		{
		}
		
		override protected function unloaded():void 
		{
			super.unloaded();
			
			removeEventListener(MouseEvent.CLICK, onClickHandler);
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
		}
	}
}