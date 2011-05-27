package com.arthwood.data {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.arthwood.math.MathUtils;
	import com.arthwood.utils.UtilsArray;

	public class List extends EventDispatcher implements IIterator {
		public var loop:Boolean = false;
		public var allowDuplicates:Boolean = true;
		
		private var _items:Array;
		private var _i:int = -1;
		
		public function List(items_:Array = null) {
			_items = (items_ || new Array());
		}
		
		public function addItem(item_:Object):void {
			addItemAt(item_, length);
		}
		
		public function removeItem(item_:Object, noEvent_:Boolean = false):void {
			var lengthBefore:uint = length;
			
			UtilsArray.removeItem(_items, item_);
			
			if ((length < lengthBefore) && !noEvent_) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		public function addItemAt(item:Object, idx:uint, noEvent:Boolean = false):void {
			if (allowDuplicates || !includes(item)) {
				_items = UtilsArray.insertAt(_items, idx, item);
				
				if (!noEvent) {
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
		
		public function removeItemAt(idx:Number, noEvent:Boolean = false):void {
			removeItem(getItemAt(idx), noEvent);
		}
		
		public function removeAllItems():void {
			_items.splice(0);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function getItemAt(position_:uint):Object {
			var vPosition:uint = loop ? (MathUtils.castToSet(position_, 0, length)) : position_;
			
			return _items[vPosition];
		}
		
		public function getItemIndex(item_:Object):uint {
			return _items.indexOf(item_);
		}
		
		public function moveItem(item_:Object, idx_:Number):void {
			removeItem(item_, true);
			addItemAt(item_, idx_);
		}
		
		public function get length():uint {
			return getLength();
		}
		
		public function get items():Array {
			return _items;
		}
		
		public function set items(items_:Array):void {
			_items = items_;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function includes(obj:Object):Boolean {
			return UtilsArray.includes(_items, obj);
		}
		
		override public function toString():String {
			return _items.toString();
		}
		
		public function setItem(item:Object):void {
			if (!includes(item)) {
				//WarningManager.warn("{List} There is no item " + item + " in List!");
				return;
			}
			
			setPointer(getItemIndex(item));
		}
		
		public function reset():void {
			_i = -1;
		}
		
		public function getPointer():int {
			return _i;
		}
		
		public function setPointer(i_:int):void {
			_i = i_;
		}
		
		public function decrease():void {
			_i--;
		}
		
		public function increase():void {
			_i++;
		}
		
		public function getCurrent():Object {
			return getItemAt(_i);
		}
		
		public function getPrev():Object {
			return getItemAt(_i - 1);
		}
		
		public function getNext():Object {
			return getItemAt(_i + 1);
		}
		
		public function getLength():uint {
			return _items.length;
		}
		
		public function get first():Object {
			return UtilsArray.getFirst(_items);
		}
		
		public function get last():Object {
			return UtilsArray.getLast(_items);
		}
		
		public function get empty():Boolean {
			return length == 0;
		}
		
		public function get isFirst():Boolean {
			return _i == 0;
		}
		
		public function get isLast():Boolean {
			return _i == (getLength() - 1);
		}
	}
}