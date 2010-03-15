package pl.arthwood.components {
	import flash.geom.Rectangle;
	import pl.arthwood.components.SimpleScroll;

	public class SimpleHScroll extends SimpleScroll {
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
			return handle.width;
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
	}
}