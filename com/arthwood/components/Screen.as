package com.arthwood.components {
	import com.arthwood.components.screenClasses.IScreen;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class Screen extends Component implements IScreen {
		protected var _visible:Boolean = true;
		
		public function Screen() {
		}
		
		public function show():void {
			setShowedState();
		}
		
		public function hide():void {
			setHiddenState();
		}
		
		public function setShowedState():void {
			_visible = true;
			
			update();
		}
		
		public function setHiddenState():void {
			_visible = false;
			
			update();
		}
		
		public function isShowed():Boolean {
			return _visible;
		}
		
		protected function update():void {
		}
	}
}