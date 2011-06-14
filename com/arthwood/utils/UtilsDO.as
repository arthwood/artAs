package com.arthwood.utils {
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class UtilsDO {
		public static function rescaleToWidth(do_:DisplayObject, w_:Number):void {
			var vRatio:Number = do_.width/do_.height;
			
			do_.height = (do_.width = w_)/vRatio;
		}
		
		public static function rescaleToHeight(do_:DisplayObject, h_:Number):void {
			var vRatio:Number = do_.width/do_.height;
			
			do_.width = vRatio*(do_.height = h_);
		}
		
		public static function rescaleToRect(do_:DisplayObject, rect_:Rectangle, onlyBigger_:Boolean = false):void {
			if (!onlyBigger_ || !rect_.containsRect(do_.getBounds(do_))) {
				rescaleTo(do_, rect_.width, rect_.height);
			}
		}
		
		public static function rescaleTo(do_:DisplayObject, w_:Number, h_:Number):void {
			rescaleToWidth(do_, w_);
			
			if (do_.height > h_) {
				rescaleToHeight(do_, h_);
			}
		}
		
		public static function setScale(do_:DisplayObject, v_:Number):void {
			do_.scaleX = do_.scaleY = v_;
		}
		
		public static function setPosition(do_:DisplayObject, x_:Number, y_:Number):void {
			do_.x = x_;
			do_.y = y_;
		}
		
		public static function getPosition(do_:DisplayObject):Point {
			return new Point(do_.x, do_.y);
		}
		
		public static function setPositionAtPoint(do_:DisplayObject, p_:Point):void {
			do_.x = p_.x;
			do_.y = p_.y;
		}
		
		public static function setSize(do_:DisplayObject, w_:Number, h_:Number):void {
			do_.width = w_;
			do_.height = h_;
		}
		
		public static function enabled(btn:SimpleButton, value:Boolean, alpha:Number = 0.2):void {
			btn.enabled = btn.mouseEnabled = value;
			btn.alpha = value ? 1 : alpha;
		}
	}
}