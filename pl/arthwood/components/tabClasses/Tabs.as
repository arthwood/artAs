package pl.arthwood.components.tabClasses {
	import flash.events.Event;
	import pl.arthwood.components.Tab;
	import pl.arthwood.managers.ScreenManager;

	public class Tabs {
		private var _screenManager:ScreenManager;
		private var _tabs:Array;
		private var _screens:Array;
		private var _groupName:String;
		
		public function Tabs(tabs_:Array, screens_:Array, groupName_:String) {
			_tabs = tabs_;
			_screens = screens_;
			_groupName = groupName_;
			_tabs.forEach(eachTab);
			_screenManager = new ScreenManager(_screens, false, false);
			Tab(tabs_[0]).selected = true;
		}
		
		private function eachTab(i_:Tab, idx_:uint, arr_:Array):void {
			i_.screen = _screens[idx_];
			i_.addEventListener(Event.SELECT, onTab);
			i_.group = _groupName;
		}
		
		private function onTab(e_:Event):void {
			_screenManager.setScreen(Tab(e_.target).screen);
		}
		
		public function hide():void {
			_screenManager.setAllToHiddenState();
		}
		
		public function show():void {
			_screenManager.setScreen(_screenManager.currentScreen);
		}
	}
}