package pl.arthwood.components {
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import pl.arthwood.components.Component;
	import pl.arthwood.math.MathUtils;
	
	public class Scroll extends Component {
		public var simpleScroll:SimpleScroll;
		public var btnArrowDown:SimpleButton;
		public var btnArrowUp:SimpleButton;
		
		private var _step:Number = 0.02;
		private var _stepUpTimer:Timer;
		private var _stepDownTimer:Timer;
		
		public function Scroll() {
			_stepUpTimer = new Timer(100);
			_stepUpTimer.addEventListener(TimerEvent.TIMER, onStepUp);
			_stepDownTimer = new Timer(100);
			_stepDownTimer.addEventListener(TimerEvent.TIMER, onStepDown);
			
			btnArrowDown.addEventListener(MouseEvent.MOUSE_DOWN, onArrowDownMouseDown);
			btnArrowUp.addEventListener(MouseEvent.MOUSE_DOWN, onArrowUpMouseDown);
			btnArrowUp.useHandCursor = btnArrowDown.useHandCursor = false;
			simpleScroll.addEventListener(Event.CHANGE, onChange);
			simpleScroll.background.addEventListener(MouseEvent.MOUSE_DOWN, onSimpleScrollBackgroundMouseDown);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e_:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowUpMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowDownMouseUp);
		}
		
		override public function dispose():void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowUpMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowDownMouseUp);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_stepUpTimer.removeEventListener(TimerEvent.TIMER, onStepUp);
			_stepDownTimer.removeEventListener(TimerEvent.TIMER, onStepDown);
		}
		
		private function onChange(event_:Event):void {
			dispatchEvent(new Event(Event.CHANGE))
		}
		
		private function onSimpleScrollBackgroundMouseDown(event_:MouseEvent):void {
			var vStep:Number = 4 * _step * MathUtils.sgn(simpleScroll.getMouseValue() - simpleScroll.value);
			
			simpleScroll.value += vStep;
		}
		
		private function onArrowDownMouseDown(event_:MouseEvent):void {
			simpleScroll.value -= _step;
			_stepDownTimer.start();
		}
		
		private function onArrowDownMouseUp(event_:MouseEvent):void {
			_stepDownTimer.stop();
		}
		
		private function onArrowUpMouseDown(event_:MouseEvent):void {
			simpleScroll.value += _step;
			_stepUpTimer.start();
		}
		
		private function onArrowUpMouseUp(event_:MouseEvent):void {
			_stepUpTimer.stop();
		}
		
		private function onStepUp(event_:TimerEvent):void {
			simpleScroll.value += _step;
		}
		
		private function onStepDown(event_:TimerEvent):void {
			simpleScroll.value -= _step;
		}
		
		public function set value(value_:Number):void {
			simpleScroll.value = value_;
		}
		
		public function get value():Number {
			return simpleScroll.value;
		}
		
		public function get step():Number {
			return _step;
		}
		
		public function set step(step_:Number):void {
			_step = MathUtils.getLimitedValue(step_, 0, 1);
		}
		
		public function set scrollVisibility(v_:Boolean):void {
			simpleScroll.visible = v_;
		}
		
		public function get scrollVisibility():Boolean {
			return simpleScroll.visible;
		}
		
		public function set handleCoef(k_:Number):void {
			simpleScroll.handleCoef = k_;
		}
		
		public function get handleCoef():Number {
			return simpleScroll.handleCoef;
		}
	}
}