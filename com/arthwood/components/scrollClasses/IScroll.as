package com.arthwood.components.scrollClasses {
	import flash.events.IEventDispatcher;
	
	public interface IScroll extends IEventDispatcher {
		function set visible(v:Boolean):void;
		function get value():Number;
		function set value(v:Number):void;
	}
}