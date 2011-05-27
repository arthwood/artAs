package com.arthwood.components {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.arthwood.components.Component;
	import com.arthwood.components.radioButtonClasses.RadioButtonGroup;
	import com.arthwood.utils.UtilsArray;
	
	public class RadioButton extends Component {
		public var btn:SimpleButton;
		public var mcSelected:MovieClip;
		
		protected var _selected:Boolean = false;
		
		private var _group:RadioButtonGroup;
		
		public function RadioButton() {
			btn.addEventListener(MouseEvent.CLICK, onClick);
			mcSelected.mouseEnabled = false;
			onSelection();
			
			if (!_group) {
				setRadioButtonGroup(RadioButtonGroup.getGroup('group'));
			}
		}
		
		private function onClick(e_:MouseEvent):void {
			selected = true;
		}
		
		// selected
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set selected(selected_:Boolean):void {
			if (_selected != selected_) {
				if (_selected = selected_) {
					var vRadios:Array = _group.radioButtons.concat();
					
					UtilsArray.removeItem(vRadios, this);
					
					for each (var i:RadioButton in vRadios) {
						i.selected = false;
					}
				}
				
				onSelection();
				dispatchEvent(new Event(Event.CHANGE));
				
				if (_selected) {
					dispatchEvent(new Event(Event.SELECT));
				}
			}
		}
		
		protected function onSelection():void {
			mcSelected.visible = _selected;
		}
		
		// group
		public function get group():String {
			return _group.name;
		}
		
		public function set group(group_:String):void {
			RadioButtonGroup.setRadioButtonGroup(group_, this);
		}
		
		// available only internally and for RadioButtonGroup class
		public function setRadioButtonGroup(radioButtonGroup_:RadioButtonGroup):void {
			_group = radioButtonGroup_;
		}
		
		override protected function updateEnabled():void {
			btn.enabled = !_disabled;
		}
	}
}