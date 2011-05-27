package com.arthwood.components.treeClasses {
	import flash.display.MovieClip;
	import com.arthwood.components.listClasses.IListItem;
	import com.arthwood.components.treeClasses.TreeNodeView;

	public class Leaf extends TreeNodeView {
		public var mcIcon:MovieClip;
		public var mcSelected:MovieClip;
		
		public function Leaf(item_:IListItem) {
			super(item_);
			
			mcIcon.mouseEnabled = false;
			mcSelected.mouseEnabled = false;
		}
		
		override public function set selected(s_:Boolean):void {
			super.selected = s_;
			
			mcSelected.visible = selected;
		}
		
		override public function setText(text_:String):void {
			super.setText(text_);
			
			mcSelected.width = btnBkg.width;
		}
	}
}