package pl.arthwood.components {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import pl.arthwood.components.Scroll;

	public class ContentScroll extends Scroll  {
		protected var _content:DisplayObject;
		protected var _mask:Sprite;
		
		public function ContentScroll() {
			addEventListener(Event.CHANGE, onChange);
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0, 0, 100, 100);
		}
		
		public function updateVisibility():void {
			visible = (_content.height > _mask.height);
		}
		
		public function update(content_:DisplayObject, size_:Point):void {
			if (_content) _content.mask = null;
			
			_content = content_;
			_content.parent.addChild(_mask);
			_content.mask = _mask;
			_mask.x = _content.x;
			_mask.y = _content.y;
			_mask.width = size_.x;
			_mask.height = size_.y;
			
			updateVisibility();
		}
		
		private function onChange(e_:Event):void {
			updateContent();
		}
		
		protected function updateContent():void {
		}
	}
}