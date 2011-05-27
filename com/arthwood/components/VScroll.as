package com.arthwood.components {
	public class VScroll extends Scroll {
		override protected function draw():void {
			super.draw();
			
			scroll.setHeight(_height - btnDown.height - btnUp.height);
			btnUp.y = scroll.y + scroll.getHeight();
		}
	}
}