package com.arthwood.components.treeClasses {
	import com.arthwood.components.listClasses.IListItem;
	import com.arthwood.components.SimpleList;
	import com.arthwood.components.treeClasses.TreeNodeView;
	import com.arthwood.events.TreeEvent;

	public class TreeNodeSimpleList extends SimpleList {
		public function TreeNodeSimpleList() {
		}
		
		override public function addItemAt(pos_:uint, item_:IListItem):void {
			super.addItemAt(pos_, item_);
			
			var vItem:TreeNodeView = TreeNodeView(_cell.getLastItem());
			
			if (vItem is Branch) {
				vItem.addEventListener(TreeEvent.LEAF_CLICK, onLeaf);
			}
		}
		
		private function onLeaf(e_:TreeEvent):void {
			dispatchEvent(new TreeEvent(TreeEvent.LEAF_CLICK, false, false, e_.list));
		}
	}
}