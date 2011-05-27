package com.arthwood.components {
	import com.arthwood.components.scrollClasses.IScroll;
	import flash.geom.Rectangle;
	import com.arthwood.components.SimpleScroll;
	
	public class SimpleHScroll extends SimpleScroll implements IScroll {
		override protected function updateHandleBounds():void {
			var vTop:Number = getTop();
			var vBottom:Number = getBottom();
			
			handle.dragBounds = new Rectangle(vBottom, handle.y, vTop - vBottom, 0);
		}
		
		override protected function getBottom():Number {
			return Math.round(track.x);
		}
		
		override protected function getHandleStart():Number {
			return handle.x;
		}
		
		override protected function getHandleLength():Number {
			return handle.getWidth();
		}
		
		override protected function getTrackLength():Number {
			return track.width;
		}
		
		override protected function setHandlePosition(v_:Number):void {
			handle.x = v_;
		}
		
		override protected function getMousePosition():Number {
			return mouseX;
		}
		
		override protected function draw():void {
			background.width = _width;
			track.width = _width;
			
			if (_handleCoefEnabled) {
				handle.setWidth(_width * _handleCoef);
			}
			
			super.draw();
		}
	}
}