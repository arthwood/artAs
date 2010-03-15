package pl.arthwood.managers {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class AlignManager {
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		public static const CENTER:String = 'center';
		public static const TOP:String = 'top';
		public static const BOTTOM:String = 'bottom';
		public static const MIDDLE:String = 'middle';
		public static const LEFT_OUT:String = 'leftOut';
		public static const RIGHT_OUT:String = 'rightOut';
		public static const TOP_OUT:String = 'topOut';
		public static const BOTTOM_OUT:String = 'bottomOut';

		public static function alignToRect(do_:DisplayObject, rect_:Rectangle, type_:String):void {
			var vPoint:Point;
			
			switch (type_) {
				case LEFT:
					vPoint = new Point(rect_.left, do_.y);
					break;
				
				case RIGHT:
					vPoint = new Point(rect_.right - do_.width, do_.y);
					break;
				
				case CENTER:
					vPoint = new Point((rect_.left + rect_.right - do_.width)/2, do_.y);
					break;
				
				case TOP:
					vPoint = new Point(do_.x, rect_.top);
					break;
				
				case BOTTOM:
					vPoint = new Point(do_.x, rect_.bottom - do_.height);
					break;
				
				case MIDDLE:
					vPoint = new Point(do_.x, (rect_.top + rect_.bottom - do_.height)/2);
					break;
				
				case LEFT_OUT:
					vPoint = new Point(rect_.left - do_.width, do_.y);
					break;
				
				case RIGHT_OUT:
					vPoint = new Point(rect_.right, do_.y);
					break;
				
				case TOP_OUT:
					vPoint = new Point(do_.x, rect_.top - do_.height);
					break;
				
				case BOTTOM_OUT:
					vPoint = new Point(do_.x, rect_.bottom);
					break;
			}
			
			do_.x = Math.round(vPoint.x);
			do_.y = Math.round(vPoint.y);
		}
		
		public static function centerToRect(do_:DisplayObject, rect_:Rectangle):void {
			alignToRect(do_, rect_, CENTER);
			alignToRect(do_, rect_, MIDDLE);
		}
	}
}