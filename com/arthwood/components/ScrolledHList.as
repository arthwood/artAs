package com.arthwood.components {
	import flash.events.Event;
	
	public class ScrolledHList extends ScrolledList {
		override protected function draw():void {
			super.draw();
			
			scroll.setWidth(_width);
			scroll.y = background.y + background.height - scroll.getHeight() + 1;
			
			updateScroll();
		}
		
		override protected function onScroll(event_:Event):void {
			_list.x = (background.width - _list.getWidth()) * SimpleScroll(event_.target).value;
		}
		
		override protected function updateScroll():void {
			var lw:Number = _list.getWidth();
			var lh:Number = _list.getHeight();
			var hr:Number = _mask.width / lw;
			var vr:Number = _mask.height / lh;
			
			scroll.visible = (lw > 0) && (hr < 1);
			scroll.value = uint(scroll.visible) * scroll.value;
		}
	}
}