package com.arthwood.components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import com.arthwood.components.Component;
	import com.arthwood.utils.UtilsTextField;

	public class TextArea extends Component {
		public var tfInput:TextField;
		public var background:MovieClip;

		override protected function init():void {
			super.init();
			
			tfInput.addEventListener(Event.CHANGE, onChanged, true);
		}
		
		override protected function draw():void {
			super.draw();
			
			background.width = _width;
			background.height = _height;
			tfInput.width = _width - 2 * tfInput.x;
			tfInput.height = _height - 2 * tfInput.y;
		}
		
		private function onChanged(e_:Event):void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get text():String {
			return tfInput.text;
		}
		
		public function set text(text_:String):void {
			tfInput.text = text_;
		}
		
		public function set autosize(autosize_:String):void {
			tfInput.autoSize = autosize_;
		}
		
		public static function setTabIndex(... args):void {
			UtilsTextField.setTabIndex.apply(null, args.map(inputToTextField));
		}
		
		public static function inputToTextField(i_:Input, idx_:uint, arr_:Array):TextField {
			return i_.tfInput;
		}
	}
}