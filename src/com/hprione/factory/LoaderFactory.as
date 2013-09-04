package com.hprione.factory
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * LoaderFactory
	 * 
	 * @author Hugo Prione
	 * @since 02/04/2011
	 */
	public class LoaderFactory
	{
		
		/**
		 * creates and returns a Loader with listeners setted
		 * 
		 * @param	onCompleteHandler Event.COMPLETE function
		 * @param	onProgressHandler ProgressEvent.PROGRESS function
		 * @param	onHttpStatusHandler HTTPStatusEvent function
		 * @param	onErrorHandler IOErrorEvent function
		 * @param	onInitHandler Event.INIT function
		 * @param	onOpenHandler Event.OPEN function
		 * @param	onUnloadHandler Event.UNLOAD function
		 * @return returns a default Loader
		 */
		public static function getLoader(onCompleteHandler:Function = null, onProgressHandler:Function = null, onHttpStatusHandler:Function = null, onErrorHandler:Function = null, onInitHandler:Function = null, onOpenHandler:Function = null, onUnloadHandler:Function = null):Loader
		{
			var loader:Loader = new Loader();
			
			if (Boolean(onCompleteHandler))
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			if (Boolean(onProgressHandler))
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			if (Boolean(onHttpStatusHandler))
				loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler);
			if (Boolean(onErrorHandler))
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			if (Boolean(onInitHandler))
				loader.contentLoaderInfo.addEventListener(Event.INIT, onInitHandler);
			if (Boolean(onOpenHandler))
				loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpenHandler);
			if (Boolean(onUnloadHandler))
				loader.contentLoaderInfo.addEventListener(Event.UNLOAD, onUnloadHandler);
				
			return loader;
		}
	}
}