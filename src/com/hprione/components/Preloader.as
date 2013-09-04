package com.hprione.components
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * Preloader
	 * 
	 * @author hprione
	 * @since 17/03/2011
	 */
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
	public class Preloader extends DisplayComponent
	{
		private var _targetLoaderInfo:LoaderInfo;
		
		public function Preloader(mouseEnabled:Boolean = false, mouseChildren:Boolean = false)
		{
			super();
			
			this.mouseEnabled = mouseEnabled;
			this.mouseChildren = mouseChildren;
			this.setPercentage(0);
		}
		
		public function setLoaderInfo(targetLoaderInfo:LoaderInfo):void
		{
			_targetLoaderInfo = targetLoaderInfo;
			_targetLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			_targetLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_targetLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
		}
		
		public function unload():void
		{
			if (!_targetLoaderInfo) {
				return;
			}
				
			_targetLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
			_targetLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_targetLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
		}
		
		protected function onCompleteHandler(e:Event):void
		{
			unload();
			dispatchEvent(e);
		}
		
		private function onIOErrorHandler(e:IOErrorEvent):void 
		{
			unload();
			dispatchEvent(e);
		}
		
		private function onProgressHandler(e:ProgressEvent):void
		{
			setPercentage(e.bytesLoaded / e.bytesTotal);
		}
		
		protected function setPercentage(value:Number):void
		{
		}
		
		override protected function unloaded():void 
		{
			super.unloaded();
			
			unload();
			_targetLoaderInfo = null;
		}
		
		public function get targetLoaderInfo():LoaderInfo {
			return _targetLoaderInfo;
		}
	}
}