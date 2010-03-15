package pl.arthwood.components {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import pl.arthwood.cell.Cell;
	import pl.arthwood.cell.Padding;
	import pl.arthwood.components.listClasses.IListItem;
	import pl.arthwood.components.listClasses.ListItem;
	import pl.arthwood.components.Component;
	import pl.arthwood.events.ListEvent;
	import pl.arthwood.math.MathUtils;
	import pl.arthwood.utils.UtilsArray;
	
	public class SimpleList extends Component {
		public var multiselection:Boolean = false;
		public var lockControl:Boolean = false;
		
		protected var _cell:Cell;
		// stores the initial item index if shift is down
		private var _shiftItemIndex:uint;
		private var _previousItem:ListItem;
		private var _selectable:Boolean = true;
		private var _hand:Boolean = false;
		private var _cnt:uint = 0;
		private var _ctrl:Boolean = false;
		private var _shift:Boolean = false;
		private var _itemOver:IListItem;
		
		public function SimpleList() {
			_cell = new Cell(Cell.VERTICAL);
			_cell.addEventListener(Event.CHANGE, onCellChange);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		override public function dispose():void {
			_cell.removeEventListener(Event.CHANGE, onCellChange);
			removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			for each (var i:ListItem in _cell.items) {
				i.removeEventListener(ListEvent.ITEM_CLICK, onItemClick);
				i.removeEventListener(ListEvent.ITEM_SIZE, onItemSize);
			}
		}
		
		protected function onCellChange(e_:Event):void {
			dispatchEvent(new Event(ListEvent.CONTENT_CHANGE));
		}
		
		private function onKeyDown(e_:KeyboardEvent):void {
			_ctrl = (e_.keyCode == Keyboard.CONTROL);
			_shift = (e_.keyCode == Keyboard.SHIFT);
		}
		
		private function onKeyUp(e_:KeyboardEvent):void {
			_ctrl = !(e_.keyCode == Keyboard.CONTROL);
			_shift = !(e_.keyCode == Keyboard.SHIFT);
		}
		
		/**
		 *	Adds items at the end of the list.
		 */
		public function addItems(items_:Array):void {
			for each (var i:IListItem in items_) {
				addItem(i);
			}
		}
		
		/**
		 *	Adds item at the end of the list.
		 */
		public function addItem(item_:IListItem):void {
			addItemAt(length, item_);
		}
		
		/**
		 *	Adds item at specified position.
		 */
		public function addItemAt(pos_:uint, item_:IListItem):void {
			var vListItem:ListItem = item_.createItem();
			
			addChild(vListItem);
			_cell.insertAt(vListItem, pos_);
			
			vListItem.addEventListener(ListEvent.ITEM_CLICK, onItemClick);
			vListItem.addEventListener(ListEvent.ITEM_SIZE, onItemSize);
			vListItem.addEventListener(ListEvent.ITEM_OVER, onItemOver);
		}
		
		private function onItemSize(e_:Event):void {
			dispatchEvent(new Event(ListEvent.ITEM_SIZE));
		}
		
		private function onItemOver(e_:Event):void {
			_itemOver = ListItem(e_.target).item;
			dispatchEvent(new Event(ListEvent.ITEM_OVER));
		}
		
		private function onItemClick(e_:Event):void {
			_onItemClick(ListItem(e_.target), false);
		}
		
		/**
		 *	Removes item at specified position.
		 */
		public function removeItemAt(pos_:uint, doNotSelectNext_:Boolean = false):void {
			_cell.removeAt(pos_, true);
			
			if (!doNotSelectNext_) {
				selectedIndex = pos_;
			}
		}
		
		/**
		 *	Removes selected item.
		 */
		public function removeSelectedItem(doNotSelectNext_:Boolean = false):void {
			removeItemAt(selectedIndex, doNotSelectNext_);
		}
		
		/**
		 *	Removes all items.
		 */
		public function removeAll():void {
			_cell.clear();
		}
		
		/**
		 *	Set items for list.
		 */
		public function set items(items_:Array):void {
			removeAll();
			addItems(items_);
		}
		
		public function get items():Array {
			return getAllItems();
		}
		
		/**
		 *	Moves item from index1_ to index2_
		 */
		public function moveItem(idx1_:uint, idx2_:uint):void {
			var vItem:ListItem = getUIItemAt(idx1_);
			
			_cell.removeAt(idx1_, false);
			_cell.insertAt(vItem, idx2_);
		}
		
		/**
		 *	"onClick" event handler of Item component.
		 */
		private function _onItemClick(item_:ListItem, noEvent_:Boolean):void {
			if (!_selectable) {
				return;
			}
			
			var vCtrl:Boolean = (_ctrl || lockControl);
			var vShift:Boolean = _shift;
			var vIdx:uint = _cell.getItemPosition(item_);
			var vChange:Boolean = (_previousItem != item_);
			
			_previousItem = item_;
			
			if (!vShift) {
				_shiftItemIndex = undefined;
			}
			
			if (vShift && multiselection) {
				if (!_shiftItemIndex) {
					_shiftItemIndex = hasSelected? selectedIndex : 0;
				}
				
				var i:uint = _shiftItemIndex;
				var vDir:int = MathUtils.sgn(vIdx - i);
				
				if (!vCtrl) {
					unselect(true);
				}
				
				while (vDir*(vIdx - i) >= 0) {
					getUIItemAt(i).selected = true;
					i += vDir;
				}
			}
			else if (vCtrl && (multiselection || !vChange)) {
				item_.selected = !item_.selected;
			}
			else {
				unselect(true);
				item_.selected = true;
			}
			
			if (!noEvent_) {
				dispatchEvent(new Event(ListEvent.ITEM_CLICK));
				
				if (vCtrl || vChange) {
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
		
		public function unselect(noEvent_:Boolean = false):void {
			var vSelectedIndices:Array = selectedIndices;
			
			for each (var i:uint in vSelectedIndices) {
				getUIItemAt(i).selected = false;
			}
			
			if (!noEvent_) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		override public function setHeight(v_:Number):void {
			super.setHeight(v_);
			
			_cell.height = __height;
		}
		
		override public function getHeight():Number {
			return _cell.height;
		}
		
		override public function setWidth(v_:Number):void {
			super.setWidth(v_);
			
			_cell.width = __width;
		}
		
		override public function getWidth():Number {
			return _cell.width;
		}
		
		public function set vertical(v_:Boolean):void {
			_cell.setOrientation(v_ ? Cell.VERTICAL : Cell.HORIZONTAL);
		}
		
		public function set spacing(s_:Number):void {
			_cell.setSpacing(s_);
		}
		
		public function getPadding():Padding {
			return _cell.getPadding();
		}
		
		public function setPadding(p_:Number):void {
			_cell.setPadding(p_);
		}
		
		/**
		 *	Returns number of items.
		 */
		public function get length():uint {
			return _cell.length;
		}
		
		/**
		 *	Returns true if there are at least one item in the List.
		 */
		public function get empty():Boolean {
			return _cell.empty;
		}
		
		/**
		 *	Returns true if list is selectable; false otherwise.
		 */
		public function get selectable():Boolean {
			return _selectable;
		}
		
		public function set selectable(selectable_:Boolean):void {
			if (!(_selectable = selectable_)) {
				unselect();
			}
		}
		
		/**
		 *	Shows or hides hand over items
		 */
		public function set hand(hand_:Boolean):void {
			_hand = hand_;
			
			for each (var i:ListItem in _cell.items) {
				i.hand = _hand;
			}
		}
		
		public function get hand():Boolean {
			return _hand;
		}
		
		/**
		 *	Returns selected item data.
		 */
		public function get hasSelected():Boolean {
			return Boolean(selectedItem);
		}
		
		public function selectPrev():void {
			selectedIndex--;
		}
		
		public function selectNext():void {
			selectedIndex++;
		}
		
		/**
		 *	Returns "index" property of selected item
		 *	(if multiselection is true returns index of last selected item).
		 */
		public function get selectedIndex():int {
			return int(UtilsArray.getLast(selectedIndices));
		}
		
		public function set selectedIndex(index_:int):void {
			selectIndex(index_, false);
		}
		
		public function setIndexAsSelected(index_:int):void {
			selectIndex(index_, true);
		}
		
		public function selectIndex(index_:int, noEvent_:Boolean):void {
			if (_selectable && (index_ < length)) {
				if (index_ > -1) {
					_onItemClick(getUIItemAt(index_), noEvent_);
				}
				else if (index_ == -1) {
					unselect(noEvent_);
				}
			}
		}
		
		/**
		 *	Returns selected item data.
		 */
		public function get selectedItem():IListItem {
			return getItemAt(selectedIndex);
		}
		
		/**
		 *	Selects item identified by item data.
		 */
		public function set selectedItem(item_:IListItem):void {
			selectedIndex = getAllItems().indexOf(item_);
		}
		
		/**
		 *	Returns selected indices as an array.
		 */
		public function get selectedIndices():Array {
			return selectedUIItems.map(uiItemToIndex);
		}
		
		private static function uiItemToIndex(i_:ListItem, idx_:uint, arr_:Array):uint {
			return i_.getId();
		}
		
		/**
		 *	Returns selected items data as an array.
		 */
		public function get selectedItems():Array {
			return selectedUIItems.map(uiItemToItem);
		}
		
		public function get selectedUIItems():Array {
			return getAllUIItems().filter(selectedUIItemFilter);
		}

		private static function selectedUIItemFilter(uiItem_:ListItem, idx_:uint, arr_:Array):Boolean {
			return uiItem_.selected;
		}
		
		/**
		 *	Returns selected item as Item component.
		 */
		public function get selectedUIItem():ListItem {
			return getUIItemAt(selectedIndex);
		}

		/**
		 *	Returns previously selected item data.
		 */
		public function get previousItem():IListItem {
			return _previousItem.item;
		}

		/**
		 *	Returns item data at given position.
		 */
		public function getItemAt(pos_:uint):IListItem {
			return getUIItemAt(pos_).item;
		}

		/**
		 *	Returns all items data.
		 */
		public function getAllItems():Array {
			return _cell.items.map(uiItemToItem);
		}
		
		private static function uiItemToItem(i_:ListItem, idx_:uint, arr_:Array):IListItem {
			return i_.item;
		}

		/**
		 *	Returns all UI items.
		 */
		public function getAllUIItems():Array {
			return _cell.items;
		}

		/**
		 *	Returns item at given position as ListItem component.
		 */
		public function getUIItemAt(pos_:uint):ListItem {
			return ListItem(_cell.getItemAt(pos_));
		}
		
		public function getLastUIItem():ListItem {
			return getUIItemAt(length - 1);
		}

		public function get isFirstSelected():Boolean {
			return (selectedIndex == 0);
		}

		public function get isLastSelected():Boolean {
			return (selectedIndex == (length - 1));
		}
		
		protected function setAlign(align_:String):void {
			_cell.hAlign = align_;
		}
		
		public function set align(align_:String):void {
			setAlign(align_);
		}
		
		public function get itemOver():IListItem {
			return _itemOver;
		}
	}
}