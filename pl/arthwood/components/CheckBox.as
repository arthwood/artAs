package pl.arthwood.components { 
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import pl.arthwood.components.Component;

	public class CheckBox extends Component {
		public var btn:SimpleButton;
		public var mcChecked:MovieClip;
		
		private var _checked:Boolean = false;
		
		public function CheckBox() {
			btn.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			mcChecked.mouseEnabled = false;
			btn.useHandCursor = false;
			mcChecked.visible = false;
		}
		
		private function _onMouseDown(e_:MouseEvent):void {
			checked = !_checked;
		}
		
		public function get checked():Boolean {
			return _checked;
		}
		
		public function set checked(checked_:Boolean):void {
			if (_checked != checked_) {
				_checked = checked_;
				mcChecked.visible = _checked;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
}