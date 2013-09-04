package com.hprione.window
{
	import com.hprione.window.events.WindowLoaderEvents;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * WindowLoader
	 * @author hprione
	 * @date 25/08/2012 17:13
	 */	
	[Event(name = "loadWindow", type = "com.hprione.window.events.WindowLoaderEvents")]
	[Event(name = "windowLoaded", type = "com.hprione.window.events.WindowLoaderEvents")]
	[Event(name = "windowUnloaded", type = "com.hprione.window.events.WindowLoaderEvents")]
	[Event(name = "windowUnloading", type = "com.hprione.window.events.WindowLoaderEvents")]
	public class WindowLoader extends EventDispatcher
	{
		public var container:DisplayObjectContainer;
		
		private var _next:Class;
		private var _nextPopup:Class;
		
		private var _data:*;
		private var _popupData:*;
		
		private var _unloading:Boolean;
		private var _unloadingPopup:Boolean;
		
		protected var _current:BaseWindow;
		protected var _currentPopup:BaseWindow;
		
		/**
		 * constructor
		 * @param	container the container where the windows will be added
		 */
		public function WindowLoader(container:DisplayObjectContainer = null)
		{
			this.container = container;
		}
		
		/**
		 * removes the events listeners of the window and removes the window from container
		 * @param	e
		 */
		protected function onUnloadWindowHandler(e:Event):void
		{
			var window:BaseWindow = e.target as BaseWindow;
			
			window.removeEventListener(WindowLoaderEvents.LOAD_WINDOW, onLoadWindowHandler);
			window.removeEventListener(Event.COMPLETE, onCompleteHandler);
			window.removeEventListener(Event.UNLOAD, onUnloadWindowHandler);
			container.removeChild(window);
			
			if (_current == window) {
				_current = null;
			} else if (_currentPopup == window) {
				_currentPopup = null;
			}
			
			if (!window.isPopup) {
				_unloading = false;
			} else {
				_unloadingPopup = false;
			}
			
			dispatchEvent(new WindowLoaderEvents(WindowLoaderEvents.WINDOW_UNLOADED));
		}
		
		/**
		 * parses the window that will be loaded
		 * @param	e
		 */
		private function onLoadWindowHandler(e:WindowLoaderEvents):void
		{
			e.stopImmediatePropagation();
			
			loadWindow(e.window, e.data, e.isPopup);
		}
		
		/**
		 * loads the window
		 * @param	window the window that will be loaded
		 */
		public function loadWindow(window:Class, data:* = null, isPopup:Boolean = false):void
		{
			if (!isPopup) {
				_next = window;
				_data = data;
				
				if (_unloading) {
					return;
				}
				
				if (_current) {
					unloadCurrent();
				} else {
					loadNextWindow();
				}
			} else {
				_nextPopup = window;
				_popupData = data;
				
				if (_unloadingPopup) {
					return;
				}
				
				if (_currentPopup) {
					unloadCurrentPopup();
				} else {
					loadNextPopup();
				}
			}
		}
		
		protected function loadNextWindow():void
		{
			var tmp:BaseWindow = _current;
			
			_current = new _next() as BaseWindow;
			_current.addEventListener(WindowLoaderEvents.LOAD_WINDOW, onLoadWindowHandler);
			_current.addEventListener(Event.COMPLETE, onCompleteHandler);
			_current.addEventListener(Event.UNLOAD, onUnloadWindowHandler);
			_current.setData(_data);
			
			if (_currentPopup) {
				container.addChildAt(_current, container.getChildIndex(_currentPopup));
			} else {
				if (tmp) {
					container.addChildAt(_current, container.getChildIndex(tmp));
				} else {
					container.addChild(_current);
				}
			}
			
			_next = null;
			dispatchEvent(new WindowLoaderEvents(WindowLoaderEvents.WINDOW_LOADED));
		}
		
		protected function loadNextPopup():void
		{
			_currentPopup = new _nextPopup() as BaseWindow;
			_currentPopup.addEventListener(WindowLoaderEvents.LOAD_WINDOW, onLoadWindowHandler);
			_currentPopup.addEventListener(Event.COMPLETE, onCompleteHandler);
			_currentPopup.addEventListener(Event.UNLOAD, onUnloadWindowHandler);
			_currentPopup.setData(_data);
			_currentPopup.isPopup = true;
			
			if (_current) {
				container.addChildAt(_currentPopup, container.getChildIndex(_current) + 1);
			} else {
				container.addChild(_currentPopup);
			}
			
			_nextPopup = null;
			dispatchEvent(new WindowLoaderEvents(WindowLoaderEvents.WINDOW_LOADED));
		}
		
		private function onCompleteHandler(e:Event):void 
		{
			if (_next) {
				loadNextWindow();
			}
			
			if (_nextPopup) {
				loadNextPopup();
			}
		}
		
		public function unloadCurrent():void
		{
			var window:BaseWindow = current;
			
			if (!window.isPopup) {
				if (!_unloading) {
					_unloading = true;
				}
			} else {
				if (!_unloadingPopup) {
					_unloadingPopup = true;
				}
			}
			
			dispatchEvent(new WindowLoaderEvents(WindowLoaderEvents.WINDOW_UNLOADING));
			window.unload();
		}
		
		public function unloadCurrentPopup():void
		{
			var window:BaseWindow = currentPopup;
			
			if (!window.isPopup) {
				if (!_unloading) {
					_unloading = true;
				}
			} else {
				if (!_unloadingPopup) {
					_unloadingPopup = true;
				}
			}
			
			dispatchEvent(new WindowLoaderEvents(WindowLoaderEvents.WINDOW_UNLOADING));
			window.unload();
		}
		
		/**
		 * the current window
		 */
		public function get current():BaseWindow
		{
			return _current;
		}
		
		public function get currentPopup():BaseWindow
		{
			return _currentPopup;
		}
	}
}