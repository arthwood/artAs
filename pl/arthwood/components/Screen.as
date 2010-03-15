package pl.arthwood.components {
	import pl.arthwood.components.screenClasses.IScreen;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class Screen extends Component implements IScreen {
		public function Screen() {
		}
		
		public function show():void {
			setShowedState();
		}
		
		public function hide():void {
			setHiddenState();
		}
		
		public function setShowedState():void {
			visible = true;
		}
		
		public function setHiddenState():void {
			visible = false;
		}
		
		public function isShowed():Boolean {
			return visible;
		}
	}
}