package com.hprione.window
{
	
	/**
	 * CircularSequence
	 * @author hprione
	 * @date 23/06/2010 10:14
	 */
	public class CircularSequence implements ISequence
	{
		
		/**
		 * constructor
		 */
		public function CircularSequence ()
		{
		}
		
		/**
		 * returns the next window of the sequence, if there is no next, returns the first window of the sequence
		 * @param	index current position of the sequence
		 * @param	length length of the sequence
		 * @return the next window of the sequence, if there is no next, returns the first window of the sequence
		 */
		public function getNext (index:int, length:int):int
		{
			if (++index >= length)
				index = 0;
			return index;
		}
		
		/**
		 * returns the previous window of the sequence, if there is no previous, returns the last window of the sequence
		 * @param	index current position of the sequence
		 * @param	length length of the sequence
		 * @return the previous window of the sequence, if there is no previous, returns the last window of the sequence
		 */
		public function getPrev (index:int, length:int):int
		{
			if (--index < 0)
				index = length - 1;
			return index;
		}
		
		/**
		 * verifies if the sequence has a next window
		 * @param	index current position of the sequence
		 * @param	length length of the sequence
		 * @return always true
		 */
		public function hasNext (index:int, length:int):Boolean
		{
			return true;
		}
		
		/**
		 * verifies if the sequence has a previous window
		 * @param	index current position of the sequence
		 * @return always true
		 */
		public function hasPrev (index:int):Boolean
		{
			return true;
		}
	}
}