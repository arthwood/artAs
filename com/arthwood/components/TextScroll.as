package com.arthwood.components {
	import com.arthwood.components.scrollClasses.IScroll;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class TextScroll {
		protected var _textField:TextField;
		protected var _scroll:IScroll;
		
		public function TextScroll(textField_:TextField, scroll_:IScroll) {
			_textField = textField_;
			_textField.addEventListener(Event.SCROLL, onScroll);
			_scroll = scroll_;
			_scroll.addEventListener(Event.CHANGE, onChange);
			
			updateVisibility();
		}
		
		public function updateVisibility():void {
			_scroll.visible = (_textField.maxScrollV > 1);
		}
		
		private function onChange(e_:Event):void {
			updateContent();
		}
		
		protected function updateContent():void {
			_textField.scrollV = Math.round((_textField.maxScrollV - 1) * _scroll.value) + 1;
		}
		
		private function onScroll(e_:Event):void {
			_scroll.value = (_textField.scrollV - 1) / (_textField.maxScrollV - 1);
		}
	}
}