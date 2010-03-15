package pl.arthwood.components {
	import flash.events.Event;
	import flash.text.TextField;
	import pl.arthwood.components.Component;
	import pl.arthwood.utils.UtilsTextField;

	public class Input extends Component {
		public var tfInput:TextField;

		public function Input() {
			tfInput.addEventListener(Event.CHANGE, onChanged, true);
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