package pl.arthwood.components.scrollClasses {
	import pl.arthwood.components.scrollClasses.Handle;
	
	public class VerticalHandle extends Handle {
		override protected function draw():void {
			background.middle.height = _height - background.top.height - background.bottom.height;
			background.bottom.y = background.middle.y + background.middle.height;
			drag.y = (_height - drag.height) / 2;
		}
	}
}