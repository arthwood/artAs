package pl.arthwood.data {
	public interface IIterator {
		function reset():void;
		function getPointer():uint;
		function setPointer(pointer_:uint):void;
		function getCurrent():Object;
		function getPrev():Object;
		function getNext():Object;
		function getLength():uint;
	}
}