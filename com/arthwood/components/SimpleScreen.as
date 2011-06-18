package com.arthwood.components {
	import com.arthwood.components.Screen;
	import flash.display.DisplayObjectContainer;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class SimpleScreen extends Screen {
		protected var _owner:DisplayObjectContainer;
		
		public function SimpleScreen(owner_:DisplayObjectContainer) {
			_owner = owner_;
		}
		
		override protected function update():void {
			super.update();
			
			_visible ? _owner.addChild(this) : _owner.removeChild(this);
		}
		
		public function get owner():DisplayObjectContainer {
			return _owner;
		}
	}
}