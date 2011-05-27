package com.arthwood.components.scrollClasses {
	public class HorizontalHandle extends Handle {
		override protected function draw():void {
			super.draw();
			
			background.middle.width = _width - background.top.width - background.bottom.width;
			background.bottom.x = background.middle.x + background.middle.width;
			drag.x = (_width - drag.width) / 2;
		}
	}
}