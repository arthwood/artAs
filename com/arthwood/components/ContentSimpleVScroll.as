package com.arthwood.components {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.arthwood.components.ContentSimpleScroll;
	
	public class ContentSimpleVScroll extends ContentSimpleScroll {
		public function ContentSimpleVScroll(scroll_:SimpleScroll, content_:DisplayObject, size_:Point) {
			super(scroll_, content_, size_);
		}
		
		override protected function updateContent():void {
			super.updateContent();
			
			_content.y = Math.round((_mask.height - _content.height)*_scroll.value + _mask.y);
		}
	}
}
