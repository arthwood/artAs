package com.arthwood.utils {
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.arthwood.math.MathUtils;

	public class Draggable extends EventDispatcher {
		public static const BEGIN:String = 'begin';
		public static const END:String = 'end';
		public static const DRAGGING:String = 'dragging';
		
		public var bounds:Rectangle;
		
		private var _draggableElement:Sprite;
		private var _activeElement:InteractiveObject;
		private var _shift:Point;
		private var _isBeingDragged:Boolean = false;
		
		public function Draggable(draggableElement_:Sprite, activeElement_:InteractiveObject) {
			_draggableElement = draggableElement_;
			_activeElement = activeElement_;
			_shift = new Point(0, 0);
			_activeElement.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
		}
		
		public function dispose():void {
			_activeElement.removeEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			_activeElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			_activeElement.stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
		}
		
		private function beginDrag(e_:Event):void {
			_shift.x = _draggableElement.mouseX;
			_shift.y = _draggableElement.mouseY;
			_activeElement.stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			_activeElement.stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			_isBeingDragged = true;
			dispatchEvent(new Event(BEGIN));
		}
		
		private function endDrag(e_:Event):void {
			_activeElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			_activeElement.stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			_isBeingDragged = false;
			dispatchEvent(new Event(END));
		}
		
		private function onDragging(e_:MouseEvent):void {
			e_.updateAfterEvent();
			
			updatePosition();
			
			dispatchEvent(new Event(DRAGGING));
		}
		
		private function updatePosition():void {
			var vPoint:Point = (new Point(_draggableElement.parent.mouseX, _draggableElement.parent.mouseY)).subtract(_shift);
			
			vPoint.x = int(vPoint.x);
			vPoint.y = int(vPoint.y);
			
			if (bounds && !bounds.containsPoint(vPoint)) {
				vPoint = MathUtils.pointAtTheEdgeOfTheRectangle(vPoint, bounds);
			}
			
			_draggableElement.x = vPoint.x;
			_draggableElement.y = vPoint.y;
		}
		
		public function get isBeingDragged():Boolean {
			return _isBeingDragged;
		}
	}
}