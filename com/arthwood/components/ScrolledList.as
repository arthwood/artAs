package com.arthwood.components {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import com.arthwood.cell.Padding;
	import com.arthwood.components.Component;
	import com.arthwood.components.listClasses.IListItem;
	import com.arthwood.components.listClasses.ListItem;
	import com.arthwood.components.SimpleScroll;
	import com.arthwood.components.SimpleList;
	import com.arthwood.events.ListEvent;
	import flash.geom.Rectangle;

	public class ScrolledList extends Component {
		public var background:MovieClip;
		public var scroll:SimpleScroll;
		
		protected var _list:SimpleList;
		protected var _mask:Shape;
		
		override protected function init():void {
			initList();
			initMask();
			
			scroll.addEventListener(Event.CHANGE, onScroll);
			
			_list.addEventListener(ListEvent.ITEM_CLICK, onItem);
			_list.addEventListener(Event.CHANGE, onChange);
			_list.addEventListener(ListEvent.CONTENT_CHANGE, onContentChange);
			_list.addEventListener(ListEvent.ITEM_SIZE, onItemSize);
			_list.addEventListener(ListEvent.ITEM_OVER, onItemOver);
			
			super.init();
		}
		
		override protected function draw():void {
			super.draw();
			
			_list.setSize(_width, _height);
			
			_mask.width = _width;
			_mask.height = _height;
			background.width = _width;
			background.height = _height;
		}
		
		override public function dispose():void {
			scroll.removeEventListener(Event.CHANGE, onScroll);
			_list.removeEventListener(ListEvent.ITEM_CLICK, onItem);
			_list.removeEventListener(Event.CHANGE, onChange);
			_list.removeEventListener(ListEvent.CONTENT_CHANGE, onContentChange);
			_list.removeEventListener(ListEvent.ITEM_SIZE, onItemSize);
		}
		
		private function initList():void {
			_list = new SimpleList();
			
			addChildAt(_list, 1);
		}
		
		private function initMask():void {
			_mask = new Shape();
			_mask.graphics.beginFill(0, 0);
			_mask.graphics.drawRect(0, 0, background.width, background.height);
			_mask.graphics.endFill();
			
			addChildAt(_mask, 2);
			
			_list.mask = _mask;
		}
		
		public function addItems(items_:Array):void {
			_list.addItems(items_);
		}
		
		public function addItem(item_:IListItem):void {
			_list.addItem(item_);
		}
		
		public function addItemAt(pos_:uint, item_:IListItem):void {
			_list.addItemAt(pos_, item_);
		}
		
		public function removeItemAt(pos_:Number):void {
			_list.removeItemAt(pos_);
		}
		
		public function removeSelectedItem(doNotSelectNext_:Boolean = false):void {
			_list.removeSelectedItem(doNotSelectNext_);
		}
		
		public function removeAll():void {
			_list.removeAll();
		}
		
		private function onItemSize(e_:Event):void {
			updateScroll();
		}
		
		private function onItemOver(e_:Event):void {
			dispatchEvent(new Event(ListEvent.ITEM_OVER));
		}
		
		private function onContentChange(e_:Event):void {
			updateScroll();
		}
		
		protected function onScroll(event_:Event):void {
		}
		
		protected function updateScroll():void {
		}
		
		private function onItem(e_:Event):void {
			dispatchEvent(new Event(ListEvent.ITEM_CLICK));
		}
		
		private function onChange(e_:Event):void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function set items(items_:Array):void {
			_list.items = items_;
		}
		
		public function get items():Array {
			return _list.items;
		}
		
		public function selectPrev():void {
			_list.selectPrev();
		}
		
		public function selectNext():void {
			_list.selectNext();
		}
		
		public function get hasSelected():Boolean {
			return _list.hasSelected;
		}
		
		public function get selectedIndex():int {
			return _list.selectedIndex;
		}
		
		public function set selectedIndex(index_:int):void {
			_list.selectedIndex = index_;
		}
		
		public function get selectedItem():IListItem {
			return _list.selectedItem;
		}
		
		public function set selectedItem(item_:IListItem):void {
			_list.selectedItem = item_;
		}
		
		public function get selectedUIItem():ListItem {
			return _list.selectedUIItem;
		}
		
		public function get allUIItems():Array {
			return _list.getAllUIItems();
		}
		
		public function getItemAt(pos_:uint):IListItem {
			return _list.getItemAt(pos_);
		}
		
		public function getUIItemAt(pos_:uint):ListItem {
			return _list.getUIItemAt(pos_);
		}
		
		public function set vertical(v_:Boolean):void {
			_list.vertical = v_;
		}
		
		public function set spacing(s_:Number):void {
			_list.spacing = s_;
		}
		
		public function getPadding():Padding {
			return _list.getPadding();
		}
		
		public function setPadding(p_:Number):void {
			_list.setPadding(p_);
		}
		
		public function set hand(hand_:Boolean):void {
			_list.hand = hand_;
		}
		
		public function get hand():Boolean {
			return _list.hand;
		}
		
		public function get length():uint {
			return _list.length;
		}
		
		public function get isFirstSelected():Boolean {
			return _list.isFirstSelected;
		}
		
		public function get isLastSelected():Boolean {
			return _list.isLastSelected;
		}
		
		public function set scrollVisibility(v_:Boolean):void {
			scroll.visible = v_;
		}
		
		public function get itemOver():IListItem {
			return _list.itemOver;
		}
	}
}