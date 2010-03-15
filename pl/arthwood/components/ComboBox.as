package pl.arthwood.components {
	import flash.events.Event;
	import pl.arthwood.components.Component;
	import pl.arthwood.components.comboBoxClasses.ComboBoxHeader;
	import pl.arthwood.components.listClasses.IListItem;
	import pl.arthwood.components.ScrolledList;
	
	public class ComboBox extends Component {
		public var header:ComboBoxHeader;
		public var list:ScrolledList;
		
		private var _expanded:Boolean = false;
		
		public function ComboBox() {
			list.hScrollVisibility = false;
			list.scrollsOutside = false;
			list.visible = _expanded;
			list.addEventListener(Event.CHANGE, onListChange);
		}
		
		public function addItem(item_:IListItem):void {
			list.addItem(item_);
		}
		
		public function addItemAt(pos_:uint, item_:IListItem):void {
			list.addItemAt(pos_, item_);
		}
		
		public function removeItemAt(pos_:uint):void {
			list.removeItemAt(pos_);
		}
		
		public function removeSelectedItem():void {
			list.removeSelectedItem();
		}
		
		public function removeAll():void {
			list.removeAll();
		}
		
		public function onListChange(e_:Event):void {
			var vList:ScrolledList = ScrolledList(e_.target);
			
			header.text = vList.selectedItem.label || '';
			setExpanded(false);
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function onHeader():void {
			setExpanded(!_expanded);
		}
		
		private function setExpanded(expanded_:Boolean):void {
			if (_expanded == expanded_) {
				return;
			}
			
			_expanded = expanded_;
			header.setExpanded(_expanded);
			list.visible = _expanded;
		}
		
		public function get selectedIndex():uint {
			return list.selectedIndex;
		}
		
		public function set selectedIndex(index_:uint):void {
			list.selectedIndex = index_;
		}
		
		public function get selectedItem():IListItem {
			return list.selectedItem;
		}
		
		public function set selectedItem(item_:IListItem):void {
			list.selectedItem = item_;
		}
		
		public function get expanded():Boolean {
			return _expanded;
		}
		
		public function set items(items_:Array):void {
			list.items = items_;
		}
		
		public function get items():Array {
			return list.items;
		}
	}
}