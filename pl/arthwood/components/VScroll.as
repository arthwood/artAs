package pl.arthwood.components {
	public class VScroll extends Scroll {
		override protected function draw():void {
			simpleScroll.setHeight(_height - btnDown.height - btnUp.height);
			btnUp.y = simpleScroll.y + simpleScroll.getHeight();
		}
	}
}