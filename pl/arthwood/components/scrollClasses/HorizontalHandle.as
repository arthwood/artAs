package pl.arthwood.components.scrollClasses {
	import pl.arthwood.components.scrollClasses.Handle;

	public class HorizontalHandle extends Handle {
		override protected function draw():void {
			background.middle.width = _width - background.top.width - background.bottom.width;
			background.bottom.x = background.middle.x + background.middle.width;
			drag.x = (_width - drag.width) / 2;
		}
	}
}