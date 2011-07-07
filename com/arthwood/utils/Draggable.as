package com.arthwood.utils {
	import com.arthwood.events.DragEvent;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.arthwood.math.MathUtils;

	public class Draggable extends EventDispatcher {
		public var bounds:Rectangle;
		
		private var _element:DisplayObject;
		private var _shift:Point;
		private var _dragging:Boolean = false;
		private var _active:Boolean = false;
		
		public function Draggable(element_:DisplayObject) {
			_element = element_;
			_shift = new Point(0, 0);
			active = true;
		}
		
		public function dispose():void {
			active = false;
			_element.removeEventListener(Event.ENTER_FRAME, onDragging);
			_element.stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
		}
		
		private function beginDrag(e_:MouseEvent):void {
			_shift.x = _element.mouseX;
			_shift.y = _element.mouseY;
			_element.addEventListener(Event.ENTER_FRAME, onDragging);
			_element.stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			_dragging = true;
			dispatchEvent(new DragEvent(DragEvent.BEGIN));
		}
		
		private function endDrag(e_:Event):void {
			_element.removeEventListener(Event.ENTER_FRAME, onDragging);
			_element.stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			_dragging = false;
			dispatchEvent(new DragEvent(DragEvent.END));
		}
		
		private function onDragging(e_:Event):void {
			updatePosition();
			dispatchEvent(new DragEvent(DragEvent.DRAG));
		}
		
		private function updatePosition():void {
			var point:Point = (new Point(_element.parent.mouseX, _element.parent.mouseY)).subtract(_shift);
			
			point.x = int(point.x);
			point.y = int(point.y);
			
			if (bounds && !bounds.containsPoint(point)) {
				point = MathUtils.getPointAtTheEdge(point, bounds);
			}
			
			_element.x = point.x;
			_element.y = point.y;
		}
		
		public function get dragging():Boolean {
			return _dragging;
		}
		
		public function get element():DisplayObject {
			return _element;
		}
		
		public function set active(v:Boolean):void {
			if (_active != v) {
				_active = v;
				
				if (_active) {
					_element.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag) 
				}
				else {
					_element.removeEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
				}
			}
		}
	}
}