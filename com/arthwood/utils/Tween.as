package com.arthwood.utils{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	* ...
	* @author Artur Bilski
	* Copyright (C) 2006 Artur Bilski. All Rights Reserved.
	*/
	public class Tween extends EventDispatcher {
		public static const LINEAR:String = 'linear';
		public static const EXPONENTIAL:String = 'exponential';
		public static const PARABOLIC:String = 'parabolic';
		
		private var _target:DisplayObject;
		private var _p1:Point;
		private var _p2:Point;
		private var _type:String;
		private var _i:Number;
		private var _n:Number;
		private var _x:Function;
		private var _y:Function;
		private var _tween:Function;
		
		public function Tween(target_:DisplayObject, p2_:Point, p1_:Point, type_:String) {
			_target = target_;
			_p2 = p2_;
			_p1 = p1_ || new Point(_target.x, _target.y);
			_type = type_;
		}
			
		public function dispose():void {
			_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function start(n_:Number, k_:Number):void {
			switch (_type) {
				case EXPONENTIAL:
					exponentialTween(n_, k_);
					break;
				case PARABOLIC:
					parabolicTween(n_, k_);
					break;
				default:
					linearTween(n_);
					break;
			}
		}
		
		public function cancel(resetPosition_:Boolean = false):void {
			_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			if (resetPosition_) {
				_target.x = _p1.x;
				_target.y = _p1.y;
			}
		}

		public function exponentialTween(n_:Number, k_:Number):void {
			initTween(n_, getExponential(k_));
		}
		
		public function linearTween(n_:Number):void {
			initTween(n_, getLinear(1, 0));
		}

		public function parabolicTween(n_:Number, k_:Number):void {
			initTween(n_, getParabolic(k_ - 1, 2 - k_, 0));
		}
		
		public function reversePoints():void {
			var vTemp:Point = _p1;
			
			_p1 = _p2;
			_p2 = vTemp;
		}
		
		private function initTween(n_:Number, tween_:Function):void {
			_x = getLinear(_p2.x - _p1.x, _p1.x);
			_y = getLinear(_p2.y - _p1.y, _p1.y);
			
			_i = 0;
			_n = n_;
			_tween = tween_;
			_target.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e_:Event):void {
			update();
		}
		
		private function update():void {
			var t:Number = _tween(_i/_n);
			
			_target.x = _x(t);
			_target.y = _y(t);
			
			if (_i++ == _n) {
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private static function getExponential(k_:Number):Function {
			var u:Number = Math.exp(k_);
			
			return function(x_:Number):Number {
				return (Math.pow(u, x_) - 1)/(u - 1);
			}
		}
		
		private static function getLinear(a_:Number, b_:Number):Function {
			return function(x_:Number):Number {
				return a_*x_ + b_;
			}
		}

		private static function getParabolic(a_:Number, b_:Number, c_:Number):Function {
			return function(x_:Number):Number {
				return a_*x_*x_ + b_*x_ + c_;
			}
		}
		
		public function set startPoint(p_:Point):void {
			_p1 = p_;
		}
		
		public function get startPoint():Point {
			return _p1;
		}
		
		public function set endPoint(p_:Point):void {
			_p2 = p_;
		}
		
		public function get endPoint():Point {
			return _p2;
		}
	}
}