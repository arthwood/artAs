package com.arthwood.cell {
	import com.arthwood.cell.ICellItem;
	import com.arthwood.cell.Padding;

	public interface ICell extends ICellItem {
		function insert(cellItem_:Object):void;
		function insertAt(cellItem_:Object, pos_:uint):void;
		function removeAt(pos_:uint, removeObj_:Boolean):void;
		function update(updateParent_:Boolean = false):void;
		function onPaddingChange(side_:String):void;
		function getItems():Array;
		function getItemsNum():uint;
		function getIdentifier():uint;
		function getLeft():Number;
		function getRight():Number;
		function getTop():Number;
		function getBottom():Number;
		function getItemPosition(item_:ICellItem):uint;
		function getOrientation():String;
		function setOrientation(orientation_:String):void;

		function getSpacing():Number;
		function setSpacing(spacing_:Number):void;

		function getHAlign():String;
		function setHAlign(hAlign_:String):void;

		function getVAlign():String;
		function setVAlign(vAlign_:String):void;

		function getPadding():Padding;
	}
}