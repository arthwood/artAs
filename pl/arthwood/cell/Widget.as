package pl.arthwood.cell {
	import pl.arthwood.cell.ICell;
	import pl.arthwood.cell.IWidget;
	import pl.arthwood.components.Component;

	public class Widget extends Component implements IWidget {
		protected var _parentCell:ICell;
		// position as an item
		private var _id:Number;
		// depth in cells' hierarchy
		private var _depth:Number = 0;
		// visibility
		private var _display:Boolean = true;
		// set by cell.update()
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function Widget() {
		}
		
		public function clear():void {
			remove();
		}
		
		public function getParentCell():ICell {
			return _parentCell;
		}
		
		public function setParentCell(parentCell_:ICell = null):void {
			_parentCell = parentCell_;
		}
		
		public function getId():uint {
			return _id;
		}
		
		public function setId(id_:uint = undefined):void {
			_id = id_;
		}
		
		public function getItemDepth():uint {
			return _depth;
		}
		
		public function setVisible(visible_:Boolean, display_:Boolean = false):void {
			visible = visible_;
			
			_display = display_;
		}
		
		public function getX():Number {
			return _x;
		}
		
		public function setX(x_:Number):void {
			x = _x = x_;
		}
		
		public function getY():Number {
			return _y;
		}
		
		public function setY(y_:Number):void {
			y = _y = y_;
		}
		
		override public function getWidth():Number {
			return uint(_display) * super.getWidth();
		}
		
		override public function getHeight():Number {
			return uint(_display) * super.getHeight();
		}
		
		protected function updateParentCell():void {
			if (_parentCell) {
				_parentCell.update(true);
			}
		}
	}
}