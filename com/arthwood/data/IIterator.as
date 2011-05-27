package com.arthwood.data {
	public interface IIterator {
		function reset():void;
		function getPointer():int;
		function setPointer(pointer_:int):void;
		function getCurrent():Object;
		function getPrev():Object;
		function getNext():Object;
		function getLength():uint;
	}
}