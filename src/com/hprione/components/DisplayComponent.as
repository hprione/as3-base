package com.hprione.components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * DisplayComponent
	 * 
	 * @author hprione
	 * @since 17/03/2011
	 */
	public class DisplayComponent extends Sprite
	{
		
		public function DisplayComponent() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		private function onAddedToStageHandler(e:Event):void 
		{
			init();
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		private function onRemovedFromStageHandler(e:Event):void 
		{
			unloaded();
			
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		protected function init():void 
		{
		}
		
		protected function unloaded():void 
		{
		}
	}
}