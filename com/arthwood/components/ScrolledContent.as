package com.arthwood.components {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ScrolledContent {
		private var _vScroll:VScroll;
		private var _hScroll:HScroll;
		private var _content:DisplayObject;
		private var _mask:Shape;
		
		public function ScrolledContent(vScroll:VScroll, hScroll:HScroll, content:DisplayObject, size:Point) {
			_vScroll = vScroll;
			_hScroll = hScroll;
			_content = content;
			
			_vScroll.addEventListener(Event.CHANGE, onChange);
			_hScroll.addEventListener(Event.CHANGE, onChange);
			
			_mask = new Shape();
			_mask.graphics.beginFill(0, 1);
			_mask.graphics.drawRect(0, 0, size.x, size.y);
			_mask.graphics.endFill();
			
			_content.parent.addChild(_mask);
			_content.mask = _mask;
			_mask.x = _content.x;
			_mask.y = _content.y;
			
			updateVisibility();
		}
		
		public function updateVisibility():void {
			updateScrolls();
			
			_hScroll.visible = (_content.width > _mask.width);
			_vScroll.visible = (_content.height > _mask.height);
		}
		
		private function onChange(e:Event):void {
			updateContent();
		}
		
		protected function updateContent():void {
			_content.x = Math.round((_mask.width - _content.width) * _hScroll.value + _mask.x);
			_content.y = Math.round((_mask.height - _content.height) * _vScroll.value + _mask.y);
		}
		
		protected function updateScrolls():void {
			var hm:Number = _mask.width - _content.width;
			var vm:Number = _mask.height - _content.height;
			
			_hScroll.value = (hm == 0) ? 0 : (_content.x - _mask.x) / hm;
			_vScroll.value = (vm == 0) ? 0 : (_content.y - _mask.y) / vm;
		}
	}
}