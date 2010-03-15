package pl.arthwood.data {
	import flash.events.EventDispatcher;
	import pl.arthwood.components.listClasses.IListItem;
	import pl.arthwood.components.listClasses.ListItem;
	import pl.arthwood.components.treeClasses.Branch;
	import pl.arthwood.components.treeClasses.Leaf;
	import pl.arthwood.data.List;
	import pl.arthwood.utils.UtilsString;
	
	public class TreeNode extends EventDispatcher implements IListItem {
		public static const LEAF:String = 'leaf';
		public static const BRANCH:String = 'branch';
		
		private var _node:XML;
		private var _nodes:List;
		private var _parent:TreeNode;
		private var _level:uint = 0;
		
		public function TreeNode(node_:XML, parent_:TreeNode = null) {
			_level = (_parent = parent_) ? (_parent.level + 1) : 0;
			_node = node_;
			
			parse();
		}
		
		private function parse():void {
			_nodes = new List();
			
			for each (var i:XML in _node.children()) {
				_nodes.addItem(new TreeNode(i, this));
			}
		}
		
		public function getNodeAt(pos_:uint):TreeNode {
			return TreeNode(_nodes.getItemAt(pos_));
		}
		
		public function get node():XML {
			return _node;
		}
		
		public function get parent():TreeNode {
			return _parent;
		}
		
		public function get isRoot():Boolean {
			return !Boolean(parent);
		}
		
		public function get isLeaf():Boolean {
			return (type == LEAF);
		}
		
		public function get isBranch():Boolean {
			return (type == BRANCH);
		}
		
		public function get nodes():Array {
			return _nodes.items;
		}
		
		public function get level():uint {
			return _level;
		}
		
		public function get name():String {
			return _node.@name;
		}
		
		public function get type():String {
			return _node.localName();
		}
		
		public function get label():String {
			return name;
		}
		
		public function createItem():ListItem {
			var vListItem:ListItem;
			
			switch (type) {
				case LEAF:
					vListItem = new Leaf(this);
					break;
					
				case BRANCH:
					vListItem = new Branch(this);
					break;
			}
			
			return vListItem;
		}
	}
}