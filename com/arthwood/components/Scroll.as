package com.arthwood.components {
	import com.arthwood.components.scrollClasses.IScroll;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.arthwood.components.Component;
	import com.arthwood.math.MathUtils;
	
	public class Scroll extends Component implements IScroll {
		public var scroll:SimpleScroll;
		public var btnDown:SimpleButton;
		public var btnUp:SimpleButton;
		
		private var _step:Number = 0.02;
		private var _stepUpTimer:Timer;
		private var _stepDownTimer:Timer;
		
		override protected function init():void {
			super.init();
			
			_stepUpTimer = new Timer(100);
			_stepUpTimer.addEventListener(TimerEvent.TIMER, onStepUp);
			_stepDownTimer = new Timer(100);
			_stepDownTimer.addEventListener(TimerEvent.TIMER, onStepDown);
			
			btnDown.addEventListener(MouseEvent.MOUSE_DOWN, onArrowDownMouseDown);
			btnUp.addEventListener(MouseEvent.MOUSE_DOWN, onArrowUpMouseDown);
			btnUp.useHandCursor = btnDown.useHandCursor = false;
			scroll.addEventListener(Event.CHANGE, onChange);
			scroll.background.addEventListener(MouseEvent.MOUSE_DOWN, onScrollBackgroundMouseDown);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e_:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowUpMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowDownMouseUp);
		}
		
		override public function dispose():void {
			super.dispose();
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowUpMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowDownMouseUp);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_stepUpTimer.removeEventListener(TimerEvent.TIMER, onStepUp);
			_stepDownTimer.removeEventListener(TimerEvent.TIMER, onStepDown);
		}
		
		private function onChange(event_:Event):void {
			dispatchEvent(new Event(Event.CHANGE))
		}
		
		private function onScrollBackgroundMouseDown(e:MouseEvent):void {
			var vStep:Number = 4 * _step * MathUtils.sgn(scroll.getMouseValue() - scroll.value);
			
			scroll.value += vStep;
		}
		
		private function onArrowDownMouseDown(e:MouseEvent):void {
			scroll.value -= _step;
			_stepDownTimer.start();
		}
		
		private function onArrowDownMouseUp(e:MouseEvent):void {
			_stepDownTimer.stop();
		}
		
		private function onArrowUpMouseDown(e:MouseEvent):void {
			scroll.value += _step;
			_stepUpTimer.start();
		}
		
		private function onArrowUpMouseUp(e:MouseEvent):void {
			_stepUpTimer.stop();
		}
		
		private function onStepUp(e:TimerEvent):void {
			scroll.value += _step;
		}
		
		private function onStepDown(e:TimerEvent):void {
			scroll.value -= _step;
		}
		
		public function set value(v:Number):void {
			scroll.value = v;
		}
		
		public function get value():Number {
			return scroll.value;
		}
		
		public function get step():Number {
			return _step;
		}
		
		public function set step(v:Number):void {
			_step = MathUtils.getLimitedValue(v, 0, 1);
		}
		
		public function set scrollVisibility(v:Boolean):void {
			scroll.visible = v;
		}
		
		public function get scrollVisibility():Boolean {
			return scroll.visible;
		}
		
		public function set handleCoef(k:Number):void {
			scroll.handleCoef = k;
		}
		
		public function get handleCoef():Number {
			return scroll.handleCoef;
		}
	}
}