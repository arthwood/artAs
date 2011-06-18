﻿package com.arthwood.components {
	import com.arthwood.components.Screen;
	import flash.display.DisplayObjectContainer;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class VisibleScreen extends Screen {
		override protected function update():void {
			super.update();
			
			visible = _visible;
		}
	}
}