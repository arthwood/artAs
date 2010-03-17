package pl.arthwood.components {
	public class HScroll extends Scroll {
		override protected function draw():void {
			simpleScroll.setWidth(_width - btnDown.width - btnUp.width);
			btnUp.x = simpleScroll.x + simpleScroll.getWidth();
		}
	}
}
