package com.arthwood.components {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.arthwood.components.ContentSimpleScroll;
	
	public class ContentSimpleHScroll extends ContentSimpleScroll {
		public function ContentSimpleHScroll(scroll_:SimpleScroll, content_:DisplayObject, size_:Point) {
			super(scroll_, content_, size_);
		}
		
		override protected function updateContent():void {
			super.updateContent();
			
			_content.x = Math.round((_mask.width - _content.width) * _scroll.value + _mask.x);
		}
		
		override protected function updateScrolls():void {
			var hm:Number = _mask.width - _content.width;
			
			_scroll.value = (hm == 0) ? 0 : (_content.x - _mask.x) / hm;
		}
	}
}
