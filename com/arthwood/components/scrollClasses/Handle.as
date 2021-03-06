package com.arthwood.components.scrollClasses {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import com.arthwood.components.Component;
	import com.arthwood.math.MathUtils;

	public class Handle extends Component {
		public var dragBounds:Rectangle;
		public var background:MovieClip;
		public var drag:MovieClip;
		
		private var _xShift:Number = 0;
		private var _yShift:Number = 0;
		private var _dragging:Boolean = false;
		
		public function Handle() {
			//dragBounds = new Rectangle(x, y, 0, 100);
			useHandCursor = false;
			addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override public function dispose():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}
		
		private function onAddedToStage(e_:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}
		
		private function _onMouseDown(event_:MouseEvent):void {
			beginDrag();
		}
		
		private function _onMouseUp(event_:MouseEvent):void {
			endDrag();
		}
		
		private function beginDrag():void {
			_xShift = mouseX;
			_yShift = mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			_dragging = true;
		}
		
		private function endDrag():void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragging);
			_dragging = false;
		}
		
		private function onDragging(e_:MouseEvent):void {
			updatePosition();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function updatePosition():void {
			var vX:Number = MathUtils.getLimitedValue(parent.mouseX - _xShift, dragBounds.left, dragBounds.right);
			var vY:Number = MathUtils.getLimitedValue(parent.mouseY - _yShift, dragBounds.top, dragBounds.bottom);
			
			x = vX
			y = vY;
		}
		
		override public function enable():void {
			super.enable();
			
			addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
		}
		
		override public function disable():void {
			super.enable();
			
			removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
		}
		
		public function get dragging():Boolean {
			return _dragging;
		}
		
		override public function getWidth():Number {
			return background.width;
		}
		
		override public function getHeight():Number {
			return background.height;
		}
	}
}