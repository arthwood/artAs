package com.arthwood.components {
	public class HScroll extends Scroll {
		override protected function draw():void {
			super.draw();
			
			scroll.setWidth(_width - btnDown.width - btnUp.width);
			btnUp.x = scroll.x + scroll.getWidth();
		}
	}
}
