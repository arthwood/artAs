package com.arthwood.managers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.arthwood.components.screenClasses.IScreen;
	import com.arthwood.data.List;
	
	public class ScreenManager extends EventDispatcher {
		private var _screens:List;
		
		public function ScreenManager(screens_:Array, loop_:Boolean = false) {
			_screens = new List(screens_);
			loop = Boolean(loop_);
		}
		
		public function addScreen(screen_:IScreen):void {
			_screens.addItem(screen_);
		}

		public function showAll():void {
			_screens.items.forEach(showBlock);
		}
		
		private static function showBlock(i_:IScreen, idx_:uint, arr_:Array):void {
			i_.show();
		}
		
		public function hideAll():void {
			_screens.items.forEach(hideBlock);
		}
		
		private static function hideBlock(i_:IScreen, idx_:uint, arr_:Array):void {
			i_.hide();
		}

		public function setAllToShowedState():void {
			_screens.items.forEach(setShowedStateBlock);
		}

		private static function setShowedStateBlock(i_:IScreen, idx_:uint, arr_:Array):void {
			i_.setShowedState();
		}
		
		public function setAllToHiddenState():void {
			_screens.items.forEach(setHiddenStateBlock);
		}
		
		private static function setHiddenStateBlock(i_:IScreen, idx_:uint, arr_:Array):void {
			i_.setHiddenState();
		}
		
		public function showPrev():void {
			setScreen(IScreen(_screens.getPrev()));
		}
		
		public function showNext():void {
			setScreen(IScreen(_screens.getNext()));
		}
		
		public function setScreenAt(i_:uint):void {
			setScreen(IScreen(_screens.getItemAt(i_)));
		}
		
		public function setScreen(screen_:IScreen):void {
			if (currentScreen) currentScreen.hide();
			
			if (screen_) {
				_screens.setItem(screen_);
				
				currentScreen.show();
			}
			else {
				_screens.reset();
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get currentScreen():IScreen {
			return IScreen(_screens.getCurrent());
		}
		
		public function get currentIndex():int {
			return _screens.getPointer();
		}
		
		public function get screens():Array {
			return _screens.items;
		}
		
		public function get length():uint {
			return _screens.length;
		}
		
		public function get loop():Boolean {
			return _screens.loop;
		}
		
		public function set loop(loop_:Boolean):void {
			_screens.loop = loop_;
		}
		
		public function get isFirst():Boolean {
			return _screens.isFirst;
		}
		
		public function get isLast():Boolean {
			return _screens.isLast;
		}
	}
}
