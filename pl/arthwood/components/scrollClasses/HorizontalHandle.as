package pl.arthwood.components.scrollClasses {
	import pl.arthwood.components.scrollClasses.Handle;

	public class HorizontalHandle extends Handle {
		override public function getMinWidth():Number {
			return background.width;
		}

		override public function getMinHeight():Number {
			return 10;
		}
	}
}