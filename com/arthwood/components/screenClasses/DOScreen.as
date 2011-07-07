package com.arthwood.components.screenClasses {
	import flash.display.DisplayObject;
	
	public class DOScreen implements IScreen {
		private var _do:DisplayObject;
		
		public function DOScreen(do_:DisplayObject) {
			_do = do_;
		}
		
		public function show():void {
			setShowedState();
		}
		
		public function hide():void {
			setHiddenState();
		}
		
		public function setShowedState():void {
			_do.visible = true;
		}
		
		public function setHiddenState():void {
			_do.visible = false;
		}
		
		public function isShowed():Boolean {
			return _do.visible;
		}
	}
}