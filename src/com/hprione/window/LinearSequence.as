package com.hprione.window
{
	
	/**
	 * LinearSequence
	 * @author hprione
	 * @date 23/06/2010 10:17
	 */
	
	public class LinearSequence implements ISequence
	{
		
		/**
		 * constructor
		 */
		public function LinearSequence ()
		{
		}
		
		/**
		 * returns the next window of the sequence, if there is no next, returns the last window of the sequence
		 * @param	index current position of the sequence
		 * @param	length length of the sequence
		 * @return the next window of the sequence, if there is no next, returns the last window of the sequence
		 */
		public function getNext (index:int, length:int):int
		{
			return Math.min (index + 1, length - 1);
		}
		
		/**
		 * returns the previous window of the sequence, if there is no previous, returns the first window of the sequence
		 * @param	index current position of the sequence
		 * @param	length length of the sequence
		 * @return the previous window of the sequence, if there is no previous, returns the first window of the sequence
		 */
		public function getPrev (index:int, length:int):int
		{
			return Math.max (index - 1, 0);
		}
		
		/**
		 * verifies if the sequence has a next window
		 * @param	index current position of the sequence
		 * @param	length length of the sequence
		 * @return if the sequence has a next window
		 */
		public function hasNext (index:int, length:int):Boolean
		{
			return (index + 1) < length;
		}
		
		/**
		 * verifies if the sequence has a previous window
		 * @param	index current position of the sequence
		 * @return if the sequence has a previous window
		 */
		public function hasPrev (index:int):Boolean
		{
			return (index - 1) > -1;
		}
	}
}