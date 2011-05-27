package com.arthwood.components.treeClasses {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.arthwood.components.listClasses.IListItem;
	import com.arthwood.components.treeClasses.TreeNodeSimpleList;
	import com.arthwood.components.treeClasses.TreeNodeView;
	import com.arthwood.data.TreeNode;
	import com.arthwood.events.ListEvent;
	import com.arthwood.events.TreeEvent;
	
	public class Branch extends TreeNodeView {
		public var nodesList:TreeNodeSimpleList;
		public var mcOpened:MovieClip;
		public var mcClosed:MovieClip;
		
		private var _expanded:Boolean;
		
		public function Branch(item_:IListItem) {
			super(item_);
			
			nodesList.addEventListener(ListEvent.CONTENT_CHANGE, onContentChange);
			nodesList.addEventListener(ListEvent.ITEM_CLICK, onItem);
			nodesList.addEventListener(TreeEvent.LEAF_CLICK, onLeaf);
			nodesList.items = TreeNode(item).nodes;
			
			mcOpened.mouseEnabled = false;
			mcClosed.mouseEnabled = false;
			
			collapse();
		}
		
		override protected function onClick(e_:MouseEvent):void {
			super.onClick(e_);
			
			toggle();
		}
		
		private function onContentChange(e_:Event):void {
			if (_parentCell) {
				_parentCell.update();
			}
		}
		
		private function onItem(e_:Event):void {
			var vTNSL:TreeNodeSimpleList = TreeNodeSimpleList(e_.target);
			var vTN:TreeNode = TreeNode(vTNSL.selectedItem);
			
			if (vTN.isLeaf) {
				dispatchEvent(new TreeEvent(TreeEvent.LEAF_CLICK, false, false, vTNSL));
			}
		}
		
		private function onLeaf(e_:TreeEvent):void {
			dispatchEvent(new TreeEvent(TreeEvent.LEAF_CLICK, false, false, e_.list));
		}
		
		override public function getWidth():Number {
			return Math.max(btnBkg.width, Number(nodesList.visible) * nodesList.getRect(this).right);
		}
		
		override public function getHeight():Number {
			return btnBkg.height + Number(_expanded) * nodesList.height;
		}
		
		public function toggle():void {
			_expanded ? collapse() : expand();
		}
		
		public function expand():void {
			setExpanded(true);
		}
		
		public function collapse():void {
			setExpanded(false);
		}
		
		private function setExpanded(expanded_:Boolean):void {
			_expanded = expanded_;
			nodesList.visible = _expanded;
			mcClosed.visible = !(mcOpened.visible = _expanded);
			
			if (_parentCell) {
				_parentCell.update();
			}
			
			onExpandedChange();
		}
		
		private function onExpandedChange():void {
		}
		
		public function get selectedItem():TreeNode {
			return TreeNode(nodesList.selectedItem);
		}
	}
}