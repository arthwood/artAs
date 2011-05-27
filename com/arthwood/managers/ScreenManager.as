package com.arthwood.managers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.arthwood.components.screenClasses.IScreen;
	import com.arthwood.data.List;
	
	public class ScreenManager extends EventDispatcher {
		private var _screens:List;

		public function ScreenManager(screens_:Array, loop_:Boolean = false, reset_:Boolean = false) {
			_screens = new List(screens_);
			loop = Boolean(loop_);
			
			if (reset_) reset();
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
		
		public function reset():void {
			_screens.reset();

			setAllToHiddenState();
			currentScreen.setShowedState();
		}
		
		public function showPrev():void {
			setScreen(IScreen(_screens.getPrev()));
		}
		
		public function showNext():void {
			setScreen(IScreen(_screens.getNext()));
		}
		
		public function setScreenAt(i_:Number):void {
			setScreen(IScreen(_screens.getItemAt(i_)));
		}
		
		public function setScreen(screen_:IScreen):void {
			if (currentScreen) currentScreen.hide();
			
			_screens.setItem(screen_);
			
			currentScreen.show();
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get currentScreen():IScreen {
			return IScreen(_screens.getCurrent());
		}
		
		public function get currentScreenNum():Number {
			return _screens.getPointer();
		}
		
		public function get screens():Array {
			return _screens.items;
		}
		
		public function get screensNum():Number {
			return _screens.length;
		}
		
		public function get loop():Boolean {
			return _screens.loop;
		}
		
		public function set loop(loop_:Boolean):void {
			_screens.loop = loop_;
		}
	}
}