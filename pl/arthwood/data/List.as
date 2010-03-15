package pl.arthwood.data {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import pl.arthwood.math.MathUtils;
	import pl.arthwood.utils.UtilsArray;

	public class List extends EventDispatcher implements IIterator {
		public var loop:Boolean = false;
		public var allowDuplicates:Boolean = true;
		
		private var _items:Array;
		private var _i:uint = 0;
		
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
		
		public function addItemAt(item_:Object, position_:uint, noEvent_:Boolean = false):void {
			if (allowDuplicates || !hasItem(item_)) {
				_items = UtilsArray.insertAt(_items, position_, item_);
				
				if (!noEvent_) {
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
		
		public function removeItemAt(position_:Number, noEvent_:Boolean = false):void {
			removeItem(getItemAt(position_), noEvent_);
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
		
		public function hasItem(obj_:Object):Boolean {
			return UtilsArray.isInArray(_items, obj_);
		}
		
		override public function toString():String {
			return _items.toString();
		}
		
		public function setItem(item_:Object):void {
			if (!hasItem(item_)) {
				//WarningManager.warn("{List} There is no item " + item_ + " in List!");
				return;
			}
			
			setPointer(getItemIndex(item_));
		}
		
		public function reset():void {
			_i = 0;
		}
		
		public function getPointer():uint {
			return _i;
		}
		
		public function setPointer(i_:uint):void {
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
			return _items[0];
		}
		
		public function get last():Object {
			return _items[length - 1];
		}
		
		public function get empty():Boolean {
			return length == 0;
		}
		
		public function get isLast():Boolean {
			return _i == (getLength() - 1);
		}
	}
}