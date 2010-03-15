package pl.arthwood.data {
	import flash.events.EventDispatcher;
	import pl.arthwood.components.listClasses.IListItem;
	import pl.arthwood.components.listClasses.ListItem;
	import pl.arthwood.components.listClasses.SelectableListItem;
	
	/**
	 * ...
	 * @author Artur Bilski
	 */
	public class ListItemData extends EventDispatcher implements IListItem {
		private var _label:String;
		private var _value:Object;
		
		public function ListItemData(label_:String, value_:Object = null) {
			_label = label_;
			_value = value_;
		}
		
		public function createItem():ListItem {
			return new SelectableListItem(this);
		}
		
		public function get label():String {
			return _label;
		}
		
		public function get value():Object {
			return _value || _label;
		}
	}
}