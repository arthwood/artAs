package pl.arthwood.data {
	import pl.arthwood.data.TreeNode;
	
	public class Tree {
		private var _xml:XML;
		private var _rootNode:TreeNode;

		public function Tree() {
		}
		
		public function parse(xml_:XML):void {
			_xml = xml_;
			_rootNode = new TreeNode(_xml);
		}

		public function get xml():XML {
			return _xml;
		}

		public function get root():TreeNode {
			return _rootNode;
		}

		public function toString():String {
			return _xml.toString();
		}
	}
}