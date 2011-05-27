package com.arthwood.components {
	import flash.events.Event;
	import com.arthwood.cell.Padding;
	import com.arthwood.components.Component;
	import com.arthwood.components.treeClasses.TreeNodeScrolledList;
	import com.arthwood.components.treeClasses.TreeNodeSimpleList;
	import com.arthwood.data.Tree;
	import com.arthwood.data.TreeNode;
	import com.arthwood.events.TreeEvent;
	
	public class TreeView extends Component {
		public var nodesList:TreeNodeScrolledList;
		
		private var _tree:Tree;
		private var _node:TreeNode;
		private var _list:TreeNodeSimpleList;
		
		public function TreeView() {
			_tree = new Tree();
			nodesList.addEventListener(TreeEvent.LEAF_CLICK, onLeaf);
		}
		
		public function parse(xml_:XML):void {
			_tree.parse(xml_);
			nodesList.items = _tree.root.nodes;
		}
		
		public function set tree(tree_:Tree):void {
			_tree = tree_;
			nodesList.items = _tree.root.nodes;
		}
		
		public function onLeaf(e_:TreeEvent):void {
			var vList:TreeNodeSimpleList = e_.list;
			
			if (_list && _list != vList) {
				_list.unselect();
			}
			
			_list = vList;
			_node = TreeNode(_list.selectedItem);
			
			dispatchEvent(new Event(Event.CHANGE, false, false));
		}
		
		public function getPadding():Padding {
			return nodesList.getPadding();
		}
		
		public function setPadding(p_:Number):void {
			nodesList.setPadding(p_);
		}
		
		public function get node():TreeNode {
			return _node;
		}
	}
}