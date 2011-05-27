package com.arthwood.managers {
	import com.arthwood.data.IAction;
	import com.arthwood.data.List;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class History extends EventDispatcher {
		private var _list:List;
		private var _recentItem:IAction;
		private var _maxItems:uint;
		
		public function History(maxItems:uint = 10) {
			_list = new List();
			_maxItems = maxItems;
		}
		
		public function add(action:IAction):void {
			var pointer:int = _list.getPointer();
			var items:Array = actualItems;
			
			_list.items = items;
			
			if (items.length == _maxItems) {
				_recentItem = IAction(_list.getItemAt(0));
				_recentItem.dispose();
				_list.removeItem(_recentItem);
				_list.decrease();
				dispatchEvent(new Event(Event.REMOVED));
			}
			
			_list.addItem(action);
			_list.increase();
			
			dispatchEvent(new Event(Event.ADDED));
		}
		
		public function undo():void {
			IAction(_list.getCurrent()).revert();
			
			_list.decrease();
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function redo():void {
			_list.increase();
			
			IAction(_list.getCurrent()).perform();
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get undoable():Boolean {
			return pointer > -1;
		}
		
		public function get redoable():Boolean {
			return pointer < length - 1;
		}
		
		public function get pointer():int {
			return _list.getPointer();
		}
		
		public function get length():uint {
			return _list.length;
		}
		
		public function get list():List {
			return _list;
		}
		
		public function get recentItem():IAction {
			return _recentItem;
		}
		
		public function getItemAt(i:uint):IAction {
			return IAction(_list.getItemAt(i));
		}
		
		public function get actualItems():Array {
			return _list.items.slice(0, pointer + 1);
		}
		
		public function clear(all:Boolean = true):void {
			all ? _list.removeAllItems() : _list.items.splice(0, pointer + 1);
			
			_list.setPointer(-1);
			
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}