package com.arthwood.cell {
	import com.arthwood.cell.ICell;
	
	public interface ICellItem {
		function clear():void;
		function getItemDepth():uint;
		
		function getParentCell():ICell;
		function setParentCell(parentCell_:ICell = null):void;
		
		function getId():uint;
		function setId(id_:uint = undefined):void;
		
		function getX():Number;
		function setX(x_:Number):void;
		
		function getY():Number;
		function setY(y_:Number):void;
		
		function getWidth():Number;
		function setWidth(width_:Number):void;
		
		function getHeight():Number;
		function setHeight(height_:Number):void;
		
		function setVisible(visible_:Boolean, display_:Boolean = false):void;
	}
}