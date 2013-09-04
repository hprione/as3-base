package com.hprione.window
{
	import com.hprione.window.events.SequenceWindowLoaderEvents;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 * SequenceWindowLoader
	 * @author hprione
	 * @date 23/06/2010 9:53
	 */
	public class SequenceWindowLoader extends WindowLoader 
	{
		private var _sequence:Array;
		private var _index:int;
		private var _type:ISequence;
		private var _direction:String;
		static public const CIRCULAR_SEQUENCE:Class = CircularSequence;
		static public const LINEAR_SEQUENCE:Class = LinearSequence;
		static public const LEFT:String = "left";
		static public const RIGHT:String = "right";
		
		/**
		 * constructor
		 * @param	container the container where the windows will be added
		 * @param	type type of sequence, LINEAR_SEQUENCE or CIRCULAR_SEQUENCE
		 */
		public function SequenceWindowLoader (container:DisplayObjectContainer, type:Class)
		{
			super (container);
			
			_type = new type ();
			removeAll ();
		}
		
		override protected function loadNextWindow():void
		{
			super.loadNextWindow();
			
			_current.addEventListener (SequenceWindowLoaderEvents.LOAD_WINDOW_BY_INDEX, parseWindow);
		}
		
		private function parseWindow (e:SequenceWindowLoaderEvents):void
		{
			loadByIndex (e.index);
		}
		
		override protected function onUnloadWindowHandler(e:Event):void 
		{
			super.onUnloadWindowHandler (e);
			
			e.target.removeEventListener (SequenceWindowLoaderEvents.LOAD_WINDOW_BY_INDEX, parseWindow);
		}
		
		/**
		 * adds a window in the sequence
		 * @param	window window that will be added
		 */
		public function addWindow (window:Class):void
		{
			_sequence.push (window);
		}
		
		/**
		 * adds a sequence of windows in the sequence
		 * @param	first first window of the sequence
		 * @param	last last window of the sequence
		 */
		/*public function addSequenceWindow (first:String, last:String):void
		{
			var _prefixe:String = first.replace(/(.*)\d+/,"$1");
			var _sequence:int = int(first.replace(/.*(\d+)/,"$1"));
			var _current:String = first;
			
			addWindow (_current);
			while (_current != last)
				addWindow (_current = _prefixe + (++_sequence).toString ());
		}
		*/
		/**
		 * removes a window from the sequence
		 * @param	window window that will be removed
		 */
		public function removeWindow (window:Class):void
		{
			var _pos:int = _sequence.indexOf (window);
			
			if (_pos > -1)
				_sequence.splice (_pos, 1);
		}
		
		/**
		 * removes all windows from the sequence
		 */
		public function removeAll ():void
		{
			_sequence = new Array();
			_index = 0;
		}
		
		/**
		 * loads a window in the sequence 
		 * @param	index the index of the window in the sequence
		 */
		public function loadByIndex (index:int):void
		{
			if (_index < index)
				_direction = RIGHT;
			else if (_index > index)
				_direction = LEFT;
				
			loadWindow (_sequence[_index = index]);
		}
		
		/**
		 * loads the first window of the sequence
		 */
		public function loadFirst ():void
		{
			if (_index > 0)
				_direction = LEFT;
				
			loadByIndex(0);
		}
		
		/**
		 * loads, if there is, the next window of the sequence
		 */
		public function loadNext ():void
		{
			if (hasNext ())
			{
				_direction = RIGHT;
				loadWindow (_sequence[_index = _type.getNext (_index, _sequence.length)]);
			}
		}
		
		/**
		 * loads, if there is, the previous window of the sequence
		 */
		public function loadPrev ():void
		{
			if (hasPrev ())
			{
				_direction = LEFT;
				loadWindow (_sequence[_index = _type.getPrev (_index, _sequence.length)]);
			}
		}
		
		/**
		 * verifies if the sequence has a next window
		 * @return if the sequence has a next window
		 */
		public function hasNext ():Boolean
		{
			return _type.hasNext (_index, _sequence.length);
		}
		
		/**
		 * verifies if the sequence has a previous window
		 * @return if the sequence has a previous window
		 */
		public function hasPrev ():Boolean
		{
			return _type.hasPrev (_index);
		}
		
		public function get index ():int { return _index; }
		
		public function get direction():String { return _direction; }
	}
}