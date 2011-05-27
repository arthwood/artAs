package com.arthwood.events {
	import flash.events.Event;
	
	public class ListEvent extends Event {
		public static const ITEM_CLICK:String = 'item click';
		public static const ITEM_SIZE:String = 'item size';
		public static const ITEM_OVER:String = 'item over';
		public static const CONTENT_CHANGE:String = 'content change';
		
		public function ListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}