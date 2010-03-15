package pl.arthwood.components.treeClasses {
	import pl.arthwood.components.ScrolledList;
	import pl.arthwood.components.treeClasses.TreeNodeSimpleList;
	import pl.arthwood.events.TreeEvent;

	public class TreeNodeScrolledList extends ScrolledList {
		public function TreeNodeScrolledList() {
			TreeNodeSimpleList(list).addEventListener(TreeEvent.LEAF_CLICK, onLeaf);
		}
		
		private function onLeaf(e_:TreeEvent):void {
			dispatchEvent(new TreeEvent(TreeEvent.LEAF_CLICK, false, false, e_.list));
		}
	}
}