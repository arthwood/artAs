package com.arthwood.cell {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.arthwood.cell.ICell;
	import com.arthwood.cell.ICellItem;
	import com.arthwood.cell.Padding;
	import com.arthwood.math.MathUtils;
	import com.arthwood.managers.AlignManager;
	
	public class Cell extends EventDispatcher implements ICell {
		public static const HORIZONTAL:String = 'horizontal';
		public static const VERTICAL:String = 'vertical';
		
		private static var CELL_COUNTER:uint = 0;
		
		private var _parentCell:ICell;
		// position as an item
		private var _id:uint;
		// unique identifier of this cell
		private var _identifier:Number;
		// depth in cells' hierarchy
		private var _depth:uint = 0;
		private var _orientation:String;
		private var _hAlign:String;
		private var _vAlign:String;
		private var _padding:Padding;
		private var _spacing:Number;
		private var _items:Array;
		private var _x:Number = 0;
		private var _y:Number = 0;
		// Size that has been set externally by user of cell
		private var _definedWidth:Number = 0;
		private var _definedHeight:Number = 0;
		private var _display:Boolean = true;
		
		public function Cell(orientation_:String = HORIZONTAL, spacing_:Number = 0, hAlign_:String = AlignManager.LEFT, vAlign_:String = AlignManager.TOP) {
			_orientation = orientation_;
			_hAlign = hAlign_;
			_vAlign = vAlign_;
			_spacing = spacing_;
			_padding = new Padding(this);
			_items = new Array();
			_identifier = CELL_COUNTER++;
		}
		
		// ICell implementation
		
		/**
		*	Inserts items to this cell.
		* 	Argument can be object that implements ICellItem or an Array of such objects.
		*/
		public function insert(cellItem_:Object):void {
			insertAt(cellItem_, length);
		}
		
		public function insertAt(cellItem_:Object, pos_:uint):void {
			if (cellItem_ is Array) {
				(cellItem_ as Array).forEach(function insertAtBlock(i_:ICellItem, idx_:uint, arr_:Array):void {
					_insertAt(i_, pos_ + idx_);
				});
			}
			else {
				_insertAt(ICellItem(cellItem_), pos_);
			}
		}
		
		private function _insertAt(cellItem_:ICellItem, pos_:uint):void {
			pos_ = MathUtils.getLimitedValue(pos_, 0, getLength());
			cellItem_.setParentCell(this);
			cellItem_.setId(pos_);
			_items.splice(pos_, 0, cellItem_);
			update(true);
		}
		
		public function removeAt(pos_:uint, removeObj_:Boolean):void {
			var vItem:ICellItem = getItemAt(pos_);
			
			vItem.setId(undefined);
			vItem.setParentCell(null);
			_items.splice(pos_, 1);
			
			if (removeObj_) {
				vItem.clear();
			}
			
			update(true);
		}
		
		public function clear():void {
			_items.forEach(clearEachItem);
			_items.splice(0);
			
			if (_parentCell) {
				_parentCell.update();
			}
		}
		
		private static function clearEachItem(i_:ICellItem, idx_:uint, arr_:Array):void {
			i_.setId(undefined);
			i_.setParentCell(null);
			i_.clear();
		}
		
		public function update(updateParent_:Boolean = false):void {
			var vX:Number = getX();
			var vY:Number = getY();
			var i:ICellItem;
			
			if (_orientation == HORIZONTAL) {
				var vH:Number = getHeight();
				
				vX += _padding.left;
				
				for each (i in _items) {
					// set x
					i.setX(vX);
					
					// change x
					vX += (i.getWidth() + _spacing);
					
					// set y
					switch (_vAlign) {
						case AlignManager.TOP:
							i.setY(vY + _padding.top);
							break;
						
						case AlignManager.MIDDLE:
							i.setY(vY + padding.top + (vH - padding.top - padding.bottom - i.getHeight())/2);
							break;
						
						case AlignManager.BOTTOM:
							i.setY(vY + vH - _padding.bottom - i.getHeight());
							break;
					}
				}
			}
			else if (_orientation == VERTICAL) {
				var vW:Number = getWidth();
				
				vY += _padding.top;
				
				for each (i in _items) {
					// set y
					i.setY(vY);
					
					// change y
					vY += (i.getHeight() + _spacing);
					
					// set x
					switch (_hAlign) {
						case AlignManager.LEFT:
							i.setX(vX + _padding.left);
							break;
						
						case AlignManager.CENTER:
							i.setX(vX + padding.left + (vW - padding.left - padding.right - i.getWidth())/2);
							break;
						
						case AlignManager.RIGHT:
							i.setX(vX + vW - _padding.right - i.getWidth());
							break;
					}
				}
			}
			
			dispatchEvent(new Event(Event.CHANGE));
			
			if (updateParent_ && _parentCell) {
				_parentCell.update();
			}
		}
		
		public function getItems():Array {
			return _items;
		}
		
		public function getItemsNum():uint {
			return _items.length;
		}
		
		public function getIdentifier():uint {
			return _identifier;
		}
		
		public function getItemDepth():uint {
			return _depth;
		}
		
		public function getItemAt(pos_:uint):ICellItem {
			return _items[pos_];
		}
		
		public function getLastItem():ICellItem {
			return _items[_items.length - 1];
		}
		
		/**
		 *
		 */
		public function getItemAtPosition(pos_:Number):ICellItem {
			var i:ICellItem
			
			if (_orientation == HORIZONTAL) {
				var vX:Number;
				
				for each (i in _items) {
					vX = i.getX();
					
					if ((pos_ >= vX) && (pos_ <= (vX + i.getWidth()))) {
						return i;
					}
				}
			}
			else if (_orientation == VERTICAL) {
				var vY:Number;
				
				for each (i in _items) {
					vY = i.getY();
					
					if ((pos_ >= vY) && (pos_ <= (vY + i.getHeight()))) {
						return i;
					}
				}
			}
			
			return null;
		}
		
		public function getWidth():Number {
			return uint(_display) * Math.max(_definedWidth, _getWidth());
		}
		
		/**
		*	Width of the cell
		*/
		private function _getWidth():Number {
			var w:Number = 0;
			var i:ICellItem;
			
			switch (_orientation) {
				case HORIZONTAL:
					for each (i in _items) {
						w += i.getWidth();
					}
					break;
				
				case VERTICAL:
					var vTempW:Number = 0;
					
					for each (i in _items) {
						if ((vTempW = i.getWidth()) > w) {
							w = vTempW;
						}
					}
					break;
			}
			
			var n:uint = length;
			
			return w + _padding.left + _padding.right + _spacing*((_orientation == HORIZONTAL && length > 1) ? (n - 1) : 0);
		}
		
		public function setWidth(width_:Number):void {
			_definedWidth = width_;
			
			update(true);
		}
		
		public function getHeight():Number {
			return Number(_display) * Math.max(_definedHeight, _getHeight());
		}
		
		/**
		*	Height of the cell
		*/
		private function _getHeight():Number {
			var h:Number = 0;
			var i:ICellItem;
			
			if (_orientation == HORIZONTAL) {
				var vTempH:Number = 0;
				
				for each (i in _items) {
					if ((vTempH = i.getHeight()) > h) {
						h = vTempH;
					}
				}
			}
			else if (_orientation == VERTICAL) {
				for each (i in _items) {
					h += i.getHeight();
				}
			}
			
			var n:uint = length;
			
			return h + _padding.top + _padding.bottom + _spacing*((_orientation == VERTICAL && n > 1) ? (n - 1) : 0);
		}
		
		public function setHeight(height_:Number):void {
			_definedHeight = height_;
			
			update(true);
		}
		
		/**
		*	orientation
		*/
		public function getOrientation():String {
			return _orientation;
		}
		
		public function setOrientation(orientation_:String):void {
			_orientation = orientation_;
			
			update(true);
		}
		
		public function getSpacing():Number {
			return _spacing;
		}
		
		/**
		*	spacing
		*/
		public function setSpacing(spacing_:Number):void {
			_spacing = spacing_;
			
			update(true);
		}
		
		/**
		*	horizontal align
		*/
		public function getHAlign():String {
			return _hAlign;
		}
		
		public function setHAlign(hAlign_:String):void {
			_hAlign = hAlign_;
			
			update(true);
		}
		
		/**
		*	vertical align
		*/
		public function getVAlign():String {
			return _vAlign;
		}
		
		public function setVAlign(vAlign_:String):void {
			_vAlign = vAlign_;
			
			update(true);
		}
		
		// returns padding
		public function getPadding():Padding {
			return _padding;
		}
		
		//
		public function setPadding(p_:Number):void {
			var p:Padding = getPadding();
			
			p.left = p.top = p.right = p.bottom = p_;
		}
		
		public function onPaddingChange(side_:String):void {
			update(true);
		}
		
		public function getLeft():Number {
			return getX();
		}
		
		public function getRight():Number {
			return getX() + getWidth();
		}
		
		public function getTop():Number {
			return getY();
		}
		
		public function getBottom():Number {
			return getY() + getHeight();
		}
		// End of ICell implementation
		
		
		// ICellItem implementation
		public function getParentCell():ICell {
			return _parentCell;
		}
		
		public function setParentCell(parentCell_:ICell = null):void {
			_parentCell = parentCell_;
			_depth = _parentCell ? _parentCell.getItemDepth() + 1 : null;
		}
		
		public function getId():uint {
			return _id;
		}
		
		public function setId(id_:uint = undefined):void {
			_id = id_;
		}
		
		public function getX():Number {
			return _x;
		}
		
		public function getItemPosition(item_:ICellItem):uint {
			return _items.indexOf(item_);
		}
		
		/**
		*	This method should be invoked only from update() of its parent cell.
		*/
		public function setX(x_:Number):void {
			_x = x_;
			
			update();
		}
		
		public function getY():Number {
			return _y;
		}
		
		/**
		*	This method should be invoked only from update() of its parent cell.
		*/
		public function setY(y_:Number):void {
			_y = y_;
		
			update();
		}
		// End of ICellItem implementation
		
		override public function toString():String {
			return "Cell# " + _identifier;
		}
		
		public function setVisible(v_:Boolean, display_:Boolean = false):void {
			var n:Number = getItemsNum();
			
			for each (var i:ICellItem in _items) {
				i.setVisible(v_);
			}
			
			_display = Boolean(display_);
			
			update(true);
		}
		
		/**
		*	GETTERS / SETTERS
		*/
		public function get x():Number {
			return getX();
		}
		
		public function get y():Number {
			return getY();
		}
		
		public function get width():Number {
			return getWidth();
		}
		
		public function set width(width_:Number):void {
			setWidth(width_);
		}
		
		public function get height():Number {
			return getHeight();
		}
		
		public function set height(height_:Number):void {
			setHeight(height_);
		}
		
		public function get orientation():String {
			return getOrientation();
		}
		
		public function set orientation(orientation_:String):void {
			setOrientation(orientation_);
		}
		
		public function get spacing():Number {
			return getSpacing();
		}
		
		public function set spacing(spacing_:Number):void {
			setSpacing(spacing_);
		}
		
		public function get hAlign():String {
			return getHAlign();
		}
		
		public function set hAlign(hAlign_:String):void {
			setHAlign(hAlign_);
		}
		
		public function get vAlign():String {
			return getVAlign();
		}
		
		public function set vAlign(vAlign_:String):void {
			setVAlign(vAlign_);
		}
		
		public function get padding():Padding {
			return getPadding();
		}
		
		public function get parentCell():ICell {
			return getParentCell();
		}
		
		public function set parentCell(parentCell_:ICell):void {
			setParentCell(parentCell_);
		}
		
		// edges
		public function get left():Number {
			return getLeft();
		}
		
		public function get right():Number {
			return getRight();
		}
		
		public function get top():Number {
			return getTop();
		}
		
		public function get bottom():Number {
			return getBottom();
		}
		//
		
		public function get depth():uint {
			return getItemDepth();
		}
		
		public function get items():Array {
			return getItems();
		}
		
		public function get itemsNum():uint {
			return getItemsNum();
		}
		
		public function get length():uint {
			return getLength();
		}
		
		public function getLength():uint {
			return getItemsNum();
		}
		
		public function get empty():Boolean {
			return length == 0;
		}
		
		public function get definedWidth():Number {
			return _definedWidth;
		}
		
		public function get definedHeight():Number {
			return _definedHeight;
		}
		// END OF GETTERS / SETTERS
	}
}