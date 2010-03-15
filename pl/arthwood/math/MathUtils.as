package pl.arthwood.math {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import pl.arthwood.utils.UtilsString;
	
	public class MathUtils {
		public static function sgn(x_:Number):Number {
			return (x_ == 0)? 0 : Math.abs(x_)/x_;
		}
	
		public static function stairs(x_:Number, a_:Number, b_:Number):Number {
			a_ = a_ || 0;
			b_ = b_ || 0;
			
			return Math.floor((x_ - a_)/(b_ - a_));
		}
		
		public static function castToSet(x_:Number, a_:Number, b_:Number):Number {
			return x_ - stairs(x_, a_, b_)*(b_ - a_);
		}
		
		public static function getLimitedValue(v_:Number, min_:Number, max_:Number):Number {
			return Math.min(Math.max(v_, min_), max_);
		}
		
		public static function pointAtTheEdgeOfTheRectangle(p_:Point, rect_:Rectangle):Point {
			return new Point(getLimitedValue(p_.x, rect_.left, rect_.right), getLimitedValue(p_.y, rect_.top, rect_.bottom));
		}
		
		/**
		 * 
		 * @param	n - number of elements
		 * @param	k - numer of columns
		 * @return
		 */
		public static function getLastColumnIndex(n:uint, k:uint):uint {
			return (n - 1) % k;
		}
		
		/**
		 * 
		 * @param	n - number of elements
		 * @param	k - numer of columns
		 * @return
		 */
		public static function getRowsNumber(n:uint, k:uint):uint {
			var p:uint = n - 1;
			
			return (p + k - p % k) / k;
		}
	}
}