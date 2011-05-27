package com.arthwood.events {
	import flash.events.Event;
	import com.arthwood.components.treeClasses.TreeNodeSimpleList;
	
	public class TreeEvent extends Event {
		public static const LEAF_CLICK:String = "leaf click";
		public static const ITEM_CLICK:String = "item click";
		
		public var list:TreeNodeSimpleList;
		
		public function TreeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, list_:TreeNodeSimpleList = null) {
			super(type, bubbles, cancelable);
			
			list = list_;
		}
	}
}