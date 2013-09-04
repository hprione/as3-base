package com.hprione.window
{
	
	/**
	 * ISequence
	 * @author hprione
	 * @date 23/06/2010 10:07
	 */	
	public interface ISequence
	{
		function getNext (index:int, length:int):int;
		function getPrev (index:int, length:int):int;
		function hasNext (index:int, length:int):Boolean;
		function hasPrev (index:int):Boolean;
	}
}