package pl.arthwood.components.listClasses {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class SelectableListItem extends ListItem {
		public var selection:MovieClip;
		
		public function SelectableListItem() {
			selection.mouseEnabled = false;
		}
		
		override protected function draw():void {
			super.draw();
			
			selection.width = _width;
			selection.height = _height;
		}
		
		override public function set selected(s_:Boolean):void {
			super.selected = s_;
			
			selection.visible = selected;
		}
	}
}