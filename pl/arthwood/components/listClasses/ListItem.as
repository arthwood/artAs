package pl.arthwood.components.listClasses {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import pl.arthwood.cell.Widget;
	import pl.arthwood.components.listClasses.IListItem;
	import pl.arthwood.events.ListEvent;
	
	public class ListItem extends Widget {
		public var btnBkg:SimpleButton;
		public var tfLabel:TextField;
		
		protected var _item:IListItem;
		protected var _active:Boolean = true;
		protected var _selected:Boolean = false;
		
		public function ListItem() {
			tfLabel.mouseEnabled = false;
			btnBkg.addEventListener(MouseEvent.CLICK, onClick);
			btnBkg.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			selected = false;
		}
		
		public function get item():IListItem {
			return _item;
		}
		
		public function set item(item_:IListItem):void {
			if (_item) {
				_item.removeEventListener(Event.CHANGE, onItemChange);
			}
			
			_item = item_;
			_item.addEventListener(Event.CHANGE, onItemChange);
			setText(item.label);
		}
		
		override protected function draw():void {
			super.draw();
			
			btnBkg.width = _width;
			btnBkg.height = _height;
			tfLabel.width = _width - tfLabel.x - 2;
			tfLabel.height = _height - tfLabel.y - 2;
		}
		
		public function set active(v_:Boolean):void {
			if (_active) return;
			
			_active = v_;
			
			if (_active) {
				btnBkg.addEventListener(MouseEvent.CLICK, onClick);
				btnBkg.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			}
			else {
				btnBkg.removeEventListener(MouseEvent.CLICK, onClick);
				btnBkg.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			}
		}
		
		public function get active():Boolean {
			return _active;
		}
		
		private function onOver(e:MouseEvent):void {
			dispatchEvent(new Event(ListEvent.ITEM_OVER));
		}
		
		override public function dispose():void {
			btnBkg.removeEventListener(MouseEvent.CLICK, onClick);
			item.removeEventListener(Event.CHANGE, onItemChange);
		}
		
		protected function onItemChange(e_:Event):void {
			setText(IListItem(e_.target).label);
		}
		
		protected function setupLabel():void {
		}
		
		protected function onClick(event_:MouseEvent):void {
			dispatchEvent(new Event(ListEvent.ITEM_CLICK));
		}
		
		public function set text(text_:String):void {
			setText(text_);
		}
		
		public function get text():String {
			return getText();
		}
		
		public function setText(text_:String):void {
			tfLabel.text = text_;
			onTextChange();
		}
		
		protected function onTextChange():void {
			updateParentCell();
		}
		
		public function getText():String {
			return tfLabel.text;
		}
		
		public function set selected(s_:Boolean):void {
			_selected = s_;
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set hand(hand_:Boolean):void {
			btnBkg.useHandCursor = hand_;
		}
		
		public function get hand():Boolean {
			return btnBkg.useHandCursor;
		}
		
		override public function getWidth():Number {
			return btnBkg.width;
		}
		
		override public function getHeight():Number {
			return btnBkg.height;
		}
		
		override public function setWidth(v_:Number):void {
			super.setWidth(v_);
			
			btnBkg.width = _width;
			tfLabel.width = _width - tfLabel.x - 2;
			
			updateParentCell();
		}
		
		override public function setHeight(v_:Number):void {
			super.setHeight(v_);
			
			btnBkg.height = _height;
			
			updateParentCell();
		}
	}
}