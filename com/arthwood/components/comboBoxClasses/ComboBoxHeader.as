package com.arthwood.components.comboBoxClasses {
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.arthwood.components.ComboBox;
	import com.arthwood.components.Component;

	public class ComboBoxHeader extends Component {
		public var btnExpand:SimpleButton;
		public var btnCollapse:SimpleButton;
		public var btnBkg:SimpleButton;
		public var tfLabel:TextField;
		public var comboBox:ComboBox;
		
		public function ComboBoxHeader() {
			btnExpand.mouseEnabled = false;
			btnCollapse.mouseEnabled = false;
			tfLabel.mouseEnabled = false;
			btnBkg.addEventListener(MouseEvent.CLICK, onBkg);
		}
		
		override protected function draw():void {
			btnBkg.width = _width;
			btnCollapse.x = _width - btnCollapse.width;
			btnExpand.x = _width - btnExpand.width;
			tfLabel.width = btnExpand.x - 2;
		}
		
		public function onBkg(e_:MouseEvent):void {
			comboBox.onHeader();
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