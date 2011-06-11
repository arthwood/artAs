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
		
		override public function setShowedState():void {
			super.setShowedState();
			
			_owner.addChild(this);
		}
		
		override public function setHiddenState():void {
			super.setHiddenState();
			
			_owner.removeChild(this);
		}
	}
}