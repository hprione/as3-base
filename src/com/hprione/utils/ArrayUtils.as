package com.hprione.utils
{
	
	/**
	 * ArrayUtils
	 * @author Hugo Prione
	 */	 
	public class ArrayUtils
	{
		
		/**
		 * returns a new array shuffled
		 * @param	list array that will be shuffled
		 * @param	times times wich the array will be shuffled
		 * @return a new array shuffled
		 */
		public static function shuffle (list:Array, times:uint):Array
		{
			list = list.concat ();
			while (times--)
			{
				for (var i:uint = 0; i < list.length; i++)
				{
					var j:int = Math.random () * list.length;
					var c:int = j;
					var item:*= list[j];
					
					while (c == j)
						c = Math.random () * list.length;
					list[j] = list[c];
					list[c] = item;
				}
			}
			return list;
		}
		
		/**
		 * sorts an array from the index position
		 * @param	list array that whill be sorted
		 * @param	index start index of sort
		 * @return an array from the index position
		 */
		public static function sort (list:Array, index:int = 0):Array
		{
			while (index < list.length - 1)
			{
				if (list[index + 1] < list[index])
					list.splice (index, 0, list.splice (index + 1, 1));
				else
					index++;
					
				list = sort (list, index);
			}
				
			return list;
		}
	}
}