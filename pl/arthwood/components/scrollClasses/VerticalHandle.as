package pl.arthwood.components.scrollClasses {
	import pl.arthwood.components.scrollClasses.Handle;

	public class VerticalHandle extends Handle {
		override public function getMinWidth():Number {
			return 10;
		}

		override public function getMinHeight():Number {
			return background.height;
		}
	}
}