package com.hprione.utils
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ZSorter
	 * 
	 * @author hprione
	 * @since 06/03/2010
	 */
	public class ZSorter
	{
		
		/**
		 * sorts the childrens of the container in accordance with their relative z
		 * @param	container the container in which the children will be ordered
		 */
		public static function sort(container:DisplayObjectContainer):void
		{
			for(var i:int = 0; i < container.numChildren - 1; i++) {
				for(var j:int = i + 1; j < container.numChildren; j++) {
					if(container.transform.matrix3D.deltaTransformVector(container.getChildAt(i).transform.matrix3D.position).z < container.transform.matrix3D.deltaTransformVector(container.getChildAt(j).transform.matrix3D.position).z) {
						container.addChildAt(container.getChildAt(i), j);
						break;
					}
				}
			}
		}
		
		public static function simpleSort(container:DisplayObjectContainer):void
		{
			for(var i:int = 0; i < container.numChildren; i++) {
				for(var j:int = i + 1; j < container.numChildren; j++) {
					if(container.getChildAt(i).z < container.getChildAt(j).z) {
						container.addChildAt(container.getChildAt(i), j);
						break;
					}
				}
			}
		}
	}
}