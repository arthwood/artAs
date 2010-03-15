package pl.arthwood.components {
	import pl.arthwood.components.Scroll;
	
	public class VScroll extends Scroll {
		override public function getMinWidth():Number {
			return simpleScroll.getMinWidth();
		}
		
		override public function getMinHeight():Number {
			return simpleScroll.getMinHeight() + btnArrowDown.height + btnArrowUp.height;
		}
	}
}