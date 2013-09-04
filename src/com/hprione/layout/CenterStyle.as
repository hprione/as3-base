package com.hprione.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * CenterStyle
	 * 
	 * @author hprione
	 * @since 16/08/2010
	 */
	public class CenterStyle
	{
		
		public static function arrange(container:DisplayObjectContainer, containerW:Number, xDis:Number, yDis:Number, offset:Number, itemW:Number, itemH:Number):void
		{
			xDis += offset;
			yDis += offset;
			
			var cols:int = Math.min(Math.floor((containerW - offset) / (itemW + xDis)), container.numChildren);
			var rows:int = Math.ceil(container.numChildren / cols);
			var lengthX:Number = cols * itemW + ((cols - 1) * xDis);
			var lengthY:Number = rows * itemH + ((rows - 1) * yDis);
			var item:DisplayObject;
			var row:int;
			var col:int;
			var newX:Number;
			var newY:Number;
			
			for(var i:int = 0; i < container.numChildren; i++)
			{
				col = i % cols;
				row = Math.floor(i / cols);
				
				item = container.getChildAt(i);
				item.x = ((col * itemW) + (col * xDis) + offset) - (lengthX * .5);
				item.y = ((row * itemH) + (row * yDis) + offset) - (lengthY * .5);
			}
		}
	}
}