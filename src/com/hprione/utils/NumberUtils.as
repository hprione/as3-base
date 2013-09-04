package com.hprione.utils
{
	import flash.system.Capabilities;
	
	/**
	 * NumberUtils
	 * @author Hugo Duarte
	 * @date 01/02/2012 23:21
	 */
	public class NumberUtils 
	{
		
		/**
		 * returns the radians converted from degrees
		 * @param	degree the value that will be converted
		 * @return the radians converted from degrees
		 */
		static public function toRadians (degrees:Number):Number
		{
			/*
			 * Math.PI / 180 = 0.017453292519943295
			 */
			return degrees * 0.017453292519943295;
		}
		
		/**
		 * returns the degrees converted from radians
		 * @param	radians the value that will be converted
		 * @return the degress converted from radians
		 */
		static public function toDegrees (radians:Number):Number
		{
			/*
			 * 180 / Math.PI = 57.29577951308232
			 */
			return radians * 57.29577951308232;
		}
		
		/**
		 * returns the digit in 00 format
		 * @param	digit the value that will be formated
		 * @return the digit in 00 format
		 */
		static public function convertDigit (digit:int):String
		{
			return digit < 10 ? "0" + String (digit) : String (digit);
		}
		
		/**
		 * returns the number in 00:00 format
		 * @param	time the number that will be formated
		 * @return the number in 00:00 format
		 */
		static public function timeFormated (time:int):String
		{
			return convertDigit (int ((time) / 60)) + ":" + convertDigit (int ((time) % 60));
		}
		
		static public function scale(width:Number, height:Number, totalWidth:Number, totalHeight:Number):Number
		{
			return Math.min(width / totalWidth, height / totalHeight);
		}
		
		static public function inchesToPixels(inches:Number):uint
		{
			return Math.round(Capabilities.screenDPI * inches);
		}
		
		static public function mmToPixels(mm:Number):uint
		{
			return Math.round(Capabilities.screenDPI * (mm / 25.4));
		}
		
		static public function getAngle(finalX:Number, finalY:Number, currentX:Number, currentY:Number):Number
		{
			return Math.atan2(finalY - currentY, finalX - currentX);
		}
		
		static public function getDistance(finalX:Number, finalY:Number, currentX:Number, currentY:Number):Number
		{
			return Math.sqrt(Math.pow(finalX - currentX, 2) + Math.pow(finalY - currentY, 2));
		}
	}
}