package com.arthwood.components {
	import com.arthwood.components.scrollClasses.IScroll;
	import flash.geom.Rectangle;
	import com.arthwood.components.SimpleScroll;

	public class SimpleVScroll extends SimpleScroll implements IScroll {
		override protected function updateHandleBounds():void {
			var vTop:Number = getTop();
			var vBottom:Number = getBottom();
			
			handle.dragBounds = new Rectangle(handle.x, vBottom, 0, vTop - vBottom);
		}
		
		override protected function getBottom():Number {
			return Math.round(track.y);
		}
		
		override protected function getHandleStart():Number {
			return handle.y;
		}
		
		override protected function getHandleLength():Number {
			return handle.getHeight();
		}
		
		override protected function getTrackLength():Number {
			return track.height;
		}
		
		override protected function setHandlePosition(v_:Number):void {
			handle.y = v_;
		}
		
		override protected function getMousePosition():Number {
			return mouseY;
		}
		
		override protected function draw():void {
			background.height = _height;
			track.height = _height;
			
			if (_handleCoefEnabled) {
				handle.setHeight(_height * _handleCoef);
			}
			
			super.draw();
		}
	}
}