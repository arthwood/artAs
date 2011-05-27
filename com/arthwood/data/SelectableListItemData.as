package com.arthwood.data {
	import com.arthwood.components.listClasses.ListItem;
	import com.arthwood.data.ListItemData;
	import com.arthwood.components.listClasses.SelectableListItem;
	
	/**
	 * ...
	 * @author Artur Bilski
	 */
	public class SelectableListItemData extends ListItemData {
		public function SelectableListItemData(label_:String, value_:Object = null) {
			super(label_, value_);
		}
		
		override public function createItem():ListItem {
			return new SelectableListItem(this);
		}
	}
}