package com.arthwood.components.scrollClasses {
	public class VerticalHandle extends Handle {
		override protected function draw():void {
			super.draw();
			
			background.middle.height = _height - background.top.height - background.bottom.height;
			background.bottom.y = background.middle.y + background.middle.height;
			drag.y = (_height - drag.height) / 2;
		}
	}
}