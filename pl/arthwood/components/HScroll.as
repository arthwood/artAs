package pl.arthwood.components {
	import pl.arthwood.components.Scroll;

	public class HScroll extends Scroll {
		override public function getMinWidth():Number {
			return simpleScroll.getMinWidth + btnArrowDown.width + btnArrowUp.width;
		}
		
		override public function getMinHeight():Number {
			return simpleScroll.getMinHeight();
		}
	}
}