package com.arthwood.data {
	public interface IAction {
		function perform():void;
		function revert():void;
		function toString():String;
		function store(object:Object):void;
		function getData():Object;
		function dispose():void;
	}
}