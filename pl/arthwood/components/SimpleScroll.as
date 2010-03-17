package pl.arthwood.components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import pl.arthwood.components.Component;
	import pl.arthwood.components.scrollClasses.Handle;
	import pl.arthwood.math.MathUtils;

	public class SimpleScroll extends Component {
		public var handle:Handle;
		public var background:MovieClip;
		public var track:MovieClip;
		
		protected var _value:Number = 0;
		protected var _handleCoef:Number = 0.4;
		
		public function SimpleScroll() {
			handle.addEventListener(Event.CHANGE, onDragging);
			track.visible = false;
			updateHandleBounds();
		}
		
		override protected function draw():void {
			super.draw();
			
			updateHandleBounds();
		}
		
		protected function updateHandleBounds():void {
		}
		
		public function onDragging(e_:Event):void {
			var vBottom:Number = getBottom();
			var vValue:Number = (getHandleStart() - vBottom)/(getTop() - vBottom);
			
			_value = vValue;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function getTop():Number {
			return Math.round(getBottom() + getTrackLength() - getHandleLength());
		}
		
		protected function getBottom():Number {
			return 0;
		}
		
		protected function getHandleStart():Number {
			return 0;
		}
		
		protected function getTrackLength():Number {
			return 0;
		}
		
		protected function getHandleLength():Number {
			return 0;
		}
		
		public function getMouseValue():Number {
			var vBottom:Number = getBottom();
			
			return MathUtils.getLimitedValue((getMousePosition() - vBottom)/(getTop() - vBottom), 0, 1);
		}
		
		protected function getMousePosition():Number {
			return 0;
		}
		
		public function setValue(v_:Number):void {
			_value = MathUtils.getLimitedValue(v_, 0, 1);
			
			var vBottom:Number = getBottom();
			
			setHandlePosition(_value*(getTop() - vBottom) + vBottom);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function setHandlePosition(v_:Number):void {
		}
		
		public function set value(v_:Number):void {
			setValue(v_);
		}
		
		public function get isDragging():Boolean {
			return handle.dragging;
		}
		
		override public function getWidth():Number {
			return background.width;
		}
		
		override public function getHeight():Number {
			return background.height;
		}
		
		public function get handleCoef():Number {
			return _handleCoef;
		}
		
		public function set handleCoef(k_:Number):void {
			_handleCoef = MathUtils.getLimitedValue(k_, 0, 1);
		}
		
		override public function enable():void {
			super.enable();
			
			background.alpha = 1;
			handle.alpha = 1;
			handle.enable();
		}
		
		override public function disable():void {
			super.disable();
			
			background.alpha = 0.4;
			handle.alpha = 0.4;
			handle.disable();
		}
	}
}