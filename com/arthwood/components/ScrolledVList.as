package com.arthwood.components {
	import flash.events.Event;
	
	public class ScrolledVList extends ScrolledList {
		override protected function draw():void {
			super.draw();
			
			scroll.setHeight(_height);
			scroll.x = background.x + background.width - scroll.getWidth() + 1;
			
			updateScroll();
		}
		
		override protected function onScroll(event_:Event):void {
			_list.y = (background.height - _list.getHeight()) * SimpleScroll(event_.target).value;
		}
		
		override protected function updateScroll():void {
			var lw:Number = _list.getWidth();
			var lh:Number = _list.getHeight();
			var hr:Number = _mask.width / lw;
			var vr:Number = _mask.height / lh;
			
			scroll.visible = (lh > 0) && (vr < 1);
			scroll.value = uint(scroll.visible) * scroll.value;
		}
	}
}