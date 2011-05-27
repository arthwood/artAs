package com.arthwood.components.radioButtonClasses {
	import com.arthwood.components.RadioButton;
	import com.arthwood.utils.UtilsArray;

	public class RadioButtonGroup {
		private static var _groups:Array = new Array();
		
		private var _radioButtons:Array;
		private var _name:String = 'RadioButtonGroup';
		
		public function RadioButtonGroup(name_:String) {
			_name = name_;
			_radioButtons = new Array();
			_groups.push(this);
		}
		
		public static function getGroup(groupName_:String):RadioButtonGroup {
			var vGroups:Array = _groups.filter(function (i_:RadioButtonGroup, idx_:uint, arr_:Array):Boolean {
				return i_.name == groupName_;
			});
			
			return (vGroups.length == 0) ? new RadioButtonGroup(groupName_) : RadioButtonGroup(vGroups[0]);
		}
		
		public static function setRadioButtonGroup(groupName_:String, radioButton_:RadioButton):void {
			var vGroup:RadioButtonGroup = getGroup(groupName_);
			
			if (vGroup.selected) {
				radioButton_.selected = false;
			}
			
			getGroup(radioButton_.group).removeRadioButton(radioButton_);
			vGroup.addRadioButton(radioButton_);
			radioButton_.setRadioButtonGroup(vGroup);
		}
		
		public function get radioButtons():Array {
			return _radioButtons;
		}
		
		public function addRadioButton(radioButton_:RadioButton):void {
			if (_radioButtons.indexOf(radioButton_) == -1) {
				_radioButtons.push(radioButton_);
			}
		}
		
		public function removeRadioButton(radioButton_:RadioButton):void {
			UtilsArray.removeItem(_radioButtons, radioButton_);
		}
		
		public function get selected():RadioButton {
			return _radioButtons.filter(filterSelected)[0];
		}
		
		private function filterSelected(i_:RadioButton, idx_:uint, arr_:Array):Boolean {
			return i_.selected;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function get length():uint {
			return _radioButtons.length;
		}
	}
}