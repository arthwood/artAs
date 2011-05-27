package com.arthwood.cell {
	import flash.geom.Rectangle;
	import com.arthwood.cell.Cell;
	import com.arthwood.managers.AlignManager;
	
	public class Padding {
		private var _cell:Cell;
		private var _rect:Rectangle;
		
		public function Padding(cell_:Cell, rect_:Rectangle = null) {
			_cell = cell_;
			_rect = rect_ || new Rectangle();
		}
		
		public function setLeft(left_:Number):void {
			_rect.left = left_;
			
			_cell.onPaddingChange(AlignManager.LEFT);
		}
		
		public function setTop(top_:Number):void {
			_rect.top = top_;
			
			_cell.onPaddingChange(AlignManager.TOP);
		}
		
		public function setRight(right_:Number):void {
			_rect.right = right_;
			
			_cell.onPaddingChange(AlignManager.RIGHT);
		}
		
		public function setBottom(bottom_:Number):void {
			_rect.bottom = bottom_;
			
			_cell.onPaddingChange(AlignManager.BOTTOM);
		}
		
		public function get left():Number {
			return _rect.left;
		}
		
		public function get right():Number {
			return _rect.right;
		}
		
		public function get top():Number {
			return _rect.top;
		}
		
		public function get bottom():Number {
			return _rect.bottom;
		}
		
		public function set left(v_:Number):void {
			_rect.left = v_;
		}
		
		public function set right(v_:Number):void {
			_rect.right = v_;
		}
		
		public function set top(v_:Number):void {
			_rect.top = v_;
		}
		
		public function set bottom(v_:Number):void {
			_rect.bottom = v_;
		}
	}
}