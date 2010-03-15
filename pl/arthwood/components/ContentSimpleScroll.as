package pl.arthwood.components {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ContentSimpleScroll {
		protected var _scroll:SimpleScroll;
		protected var _content:DisplayObject;
		protected var _mask:Sprite;
		
		public function ContentSimpleScroll(scroll_:SimpleScroll, content_:DisplayObject, size_:Point) {
			_scroll = scroll_;
			_scroll.addEventListener(Event.CHANGE, onChange);
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0xaaaaaa, 0.5);
			_mask.graphics.drawRect(0, 0, 100, 100);
			
			_content = content_;
			_content.parent.addChild(_mask);
			_content.mask = _mask;
			_mask.x = _content.x;
			_mask.y = _content.y;
			_mask.width = size_.x;
			_mask.height = size_.y;
			
			updateVisibility();
		}
		
		public function updateVisibility():void {
			_scroll.visible = (_content.height > _mask.height);
		}
		
		private function onChange(e_:Event):void {
			updateContent();
		}
		
		protected function updateContent():void {
		}
	}
}