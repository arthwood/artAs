package pl.arthwood.components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import pl.arthwood.cell.Padding;
	import pl.arthwood.components.Component;
	import pl.arthwood.components.listClasses.IListItem;
	import pl.arthwood.components.listClasses.ListItem;
	import pl.arthwood.components.SimpleHScroll;
	import pl.arthwood.components.SimpleList;
	import pl.arthwood.components.SimpleVScroll;
	import pl.arthwood.events.ListEvent;

	public class ScrolledList extends Component {
		public var list:SimpleList;
		public var vScroll:SimpleVScroll;
		public var hScroll:SimpleHScroll;
		public var maskClip:MovieClip;
		public var background:MovieClip;
		
		public function ScrolledList() {
			vScroll.addEventListener(Event.CHANGE, onVScroll);
			hScroll.addEventListener(Event.CHANGE, onHScroll);
			list.mask = maskClip;
			list.addEventListener(ListEvent.ITEM_CLICK, onItem);
			list.addEventListener(Event.CHANGE, onChange);
			list.addEventListener(ListEvent.CONTENT_CHANGE, onContentChange);
			list.addEventListener(ListEvent.ITEM_SIZE, onItemSize);
			list.addEventListener(ListEvent.ITEM_OVER, onItemOver);
		}
		
		override protected function draw():void {
			super.draw();
			
			list.setSize(_width, _height);
			vScroll.setSize(_width - vScroll.getWidth(), _height);
			hScroll.setSize(_width, _height - vScroll.getHeight());
			maskClip.width = _width;
			maskClip.height = _height;
			background.width = _width;
			background.height = _height;
			
			updateScrolls();
		}
		
		override public function dispose():void {
			vScroll.removeEventListener(Event.CHANGE, onVScroll);
			hScroll.removeEventListener(Event.CHANGE, onHScroll);
			list.removeEventListener(ListEvent.ITEM_CLICK, onItem);
			list.removeEventListener(Event.CHANGE, onChange);
			list.removeEventListener(ListEvent.CONTENT_CHANGE, onContentChange);
			list.removeEventListener(ListEvent.ITEM_SIZE, onItemSize);
		}
		
		public function addItems(items_:Array):void {
			list.addItems(items_);
		}
		
		public function addItem(item_:IListItem):void {
			list.addItem(item_);
		}
		
		public function addItemAt(pos_:uint, item_:IListItem):void {
			list.addItemAt(pos_, item_);
		}
		
		public function removeItemAt(pos_:Number):void {
			list.removeItemAt(pos_);
		}
		
		public function removeSelectedItem(doNotSelectNext_:Boolean = false):void {
			list.removeSelectedItem(doNotSelectNext_);
		}
		
		public function removeAll():void {
			list.removeAll();
		}
		
		private function onItemSize(e_:Event):void {
			updateScrolls();
		}
		
		private function onItemOver(e_:Event):void {
			dispatchEvent(new Event(ListEvent.ITEM_OVER));
		}
		
		private function onContentChange(e_:Event):void {
			updateScrolls();
		}
		
		private function onHScroll(event_:Event):void {
			list.x = (background.width - list.getWidth())*SimpleScroll(event_.target).value;
		}
		
		private function onVScroll(event_:Event):void {
			list.y = (background.height - list.getHeight())*SimpleScroll(event_.target).value;
		}
		
		private function updateScrolls():void {
			var lw:Number = list.getWidth();
			var lh:Number = list.getHeight();
			var hr:Number = maskClip.width/lw;
			var vr:Number = maskClip.height/lh;
			
			vScroll.visible = (lh > 0) && (vr < 1);
			vScroll.value = uint(vScroll.visible)*vScroll.value;
			vScroll.handleCoef = vr + minScrollHeight*(1 - vr)/vScroll.height;
			
			hScroll.visible = (lw > 0) && (hr < 1);
			hScroll.value = uint(hScroll.visible)*hScroll.value;
			hScroll.handleCoef = hr + minScrollWidth*(1 - hr)/hScroll.width;
		}
		
		private function onItem(e_:Event):void {
			dispatchEvent(new Event(ListEvent.ITEM_CLICK));
		}
		
		private function onChange(e_:Event):void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function set items(items_:Array):void {
			list.items = items_;
		}
		
		public function get items():Array {
			return list.items;
		}
		
		public function selectPrev():void {
			list.selectPrev();
		}
		
		public function selectNext():void {
			list.selectNext();
		}
		
		public function get hasSelected():Boolean {
			return list.hasSelected;
		}
		
		public function get selectedIndex():int {
			return list.selectedIndex;
		}
		
		public function set selectedIndex(index_:int):void {
			list.selectedIndex = index_;
		}
		
		public function get selectedItem():IListItem {
			return list.selectedItem;
		}
		
		public function set selectedItem(item_:IListItem):void {
			list.selectedItem = item_;
		}
		
		public function get selectedUIItem():ListItem {
			return list.selectedUIItem;
		}
		
		public function get allUIItems():Array {
			return list.getAllUIItems();
		}
		
		public function getItemAt(pos_:uint):IListItem {
			return list.getItemAt(pos_);
		}
		
		public function getUIItemAt(pos_:uint):ListItem {
			return list.getUIItemAt(pos_);
		}
		
		public function set vertical(v_:Boolean):void {
			list.vertical = v_;
		}
		
		public function set spacing(s_:Number):void {
			list.spacing = s_;
		}
		
		public function getPadding():Padding {
			return list.getPadding();
		}
		
		public function setPadding(p_:Number):void {
			list.setPadding(p_);
		}
		
		public function set hand(hand_:Boolean):void {
			list.hand = hand_;
		}
		
		public function get hand():Boolean {
			return list.hand;
		}
		
		public function get length():uint {
			return list.length;
		}
		
		public function get minScrollWidth():Number {
			return hScroll.getWidth();
		}
		
		public function get minScrollHeight():Number {
			return vScroll.getHeight();
		}
		
		public function get isFirstSelected():Boolean {
			return list.isFirstSelected;
		}

		public function get isLastSelected():Boolean {
			return list.isLastSelected;
		}
		
		public function set vScrollVisibility(v_:Boolean):void {
			vScroll.visible = v_;
		}
		
		public function set hScrollVisibility(v_:Boolean):void {
			hScroll.visible = v_;
		}
		
		public function get itemOver():IListItem {
			return list.itemOver;
		}
	}
}