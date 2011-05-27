package com.arthwood.components.screenClasses {
	public interface IScreen {
		function show():void;
		function hide():void;
		function setShowedState():void;
		function setHiddenState():void;
		function isShowed():Boolean;
	}
}