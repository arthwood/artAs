﻿package com.arthwood.components.treeClasses {
	import flash.display.MovieClip;
	import flash.text.TextFieldAutoSize;
	import com.arthwood.components.listClasses.IListItem;
	import com.arthwood.components.listClasses.ListItem;
	import com.arthwood.data.TreeNode;

	public class TreeNodeView extends ListItem {
		public function TreeNodeView(item_:IListItem) {
			super(item_);
			
			tfLabel.autoSize = TextFieldAutoSize.LEFT;
			
			// re-set text to reflect autoSize value
			setText(item.label);
		}
		
		override public function setText(text_:String):void {
			super.setText(text_);
			
			btnBkg.width = tfLabel.x + tfLabel.width + 2;
		}
	}
}