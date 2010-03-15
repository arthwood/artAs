package pl.arthwood.components.listClasses {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class SelectableListItem extends ListItem {
		public var mcSelected:MovieClip;
		
		public function SelectableListItem(item_:IListItem) {
			super(item_);
			
			mcSelected.mouseEnabled = false;
		}
		
		override public function set selected(s_:Boolean):void {
			super.selected = s_;
			
			mcSelected.visible = selected;
		}
	}
}