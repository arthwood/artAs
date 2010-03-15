package pl.arthwood.components.comboBoxClasses {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import pl.arthwood.components.ComboBox;
	import pl.arthwood.components.Component;

	public class ComboBoxHeader extends Component {
		public var btnExpand:SimpleButton;
		public var btnCollapse:SimpleButton;
		public var btnBkg:SimpleButton;
		public var tfLabel:TextField;
		
		private var _comboBox:ComboBox;
		
		public function ComboBoxHeader() {
			_comboBox = ComboBox(parent);
			btnExpand.mouseEnabled = false;
			btnCollapse.mouseEnabled = false;
			tfLabel.mouseEnabled = false;
			btnBkg.addEventListener(MouseEvent.CLICK, onBkg);
		}
		
		public function onBkg(e_:MouseEvent):void {
			_comboBox.onHeader();
		}

		public function setExpanded(expanded_:Boolean):void {
			btnExpand.visible = !(btnCollapse.visible = expanded_);
		}

		public function set text(text_:String):void {
			tfLabel.text = text_;
		}

		public function get text():String {
			return tfLabel.text;
		}
	}
}