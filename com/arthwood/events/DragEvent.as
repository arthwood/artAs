package com.arthwood.events {
	import flash.events.Event;
	
	public class DragEvent extends Event {
		public static const BEGIN:String = 'begin';
		public static const END:String = 'end';
		public static const DRAG:String = 'drag';
		
		public function DragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
