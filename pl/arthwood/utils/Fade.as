package pl.arthwood.utils {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import pl.arthwood.math.MathUtils;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class Fade extends EventDispatcher {
		private var _target:DisplayObject;
		private var _af:Number;
		private var _ai:Number;
		private var _alpha:Number;
		private var _delta:Number;
		private var _direction:int;
		
		public function Fade(target_:DisplayObject) {
			_target = target_;
		}
		
		public function start(af_:Number = 1, ai_:Number = NaN, delta_:Number = 0.05):void {
			cancel();
			
			_af = af_;
			_ai = isNaN(ai_) ? _target.alpha : ai_;
			_direction = MathUtils.sgn(_af - _ai);
			_delta = _direction*delta_;
			_alpha = _ai;
			_target.alpha = _alpha;
			_target.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function cancel(restore_:Boolean = false):void {
			_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			if (restore_) {
				_target.alpha = _ai;
			}
		}
		
		private function onEnterFrame(e_:Event):void {
			update();
		}
		
		private function update():void {
			if (_direction * ((_alpha += _delta) - _af) < 0) {
				_target.alpha = _alpha;
			}
			else {
				cancel();
				_target.alpha = _af;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		override public function toString():String {
			return 'Fade {from: ' + _ai + ', to: ' + _af + ', delta: ' + _delta + '}'
		}
	}
}