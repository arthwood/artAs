package pl.arthwood.components {
	import pl.arthwood.components.ContentScroll;

	public class ContentVScroll extends ContentScroll {
		public function ContentVScroll() {
		}
		
		override protected function updateContent():void {
			super.updateContent();
			
			_content.y = Math.round((_mask.height - _content.height)*value + _mask.y);
		}
	}
}