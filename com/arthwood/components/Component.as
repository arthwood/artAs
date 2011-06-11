package com.arthwood.components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class Component extends MovieClip {
		public var data:Object;
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _disabled:Boolean = false;
		
		public function Component() {
			init();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			added();
		}
		
		protected function added():void {
		}
		
		protected function init():void {
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			_width = width;
			_height = height;
			
			scaleX = 1;
			scaleY = 1;
			
			draw();
		}
		
		public function setSize(w:Number, h:Number):void {
			_width = w;
			_height = h;
			
			draw();
		}
		
		protected function draw():void {
		}
		
		private function onRemovedFromStage(e_:Event):void {
			dispose();
		}
		
		public function dispose():void {
		}
		
		public function remove():void {
			parent.removeChild(this);
		}
		
		public function getWidth():Number {
			return width;
		}
		
		public function getHeight():Number {
			return height;
		}
		
		public function setWidth(v_:Number):void {
			setSize(v_, _height);
		}
		
		public function setHeight(v_:Number):void {
			setSize(_width, v_);
		}
		
		public function setPosition(p_:Point):void {
			x = p_.x;
			y = p_.y;
		}
		
		public function getPosition():Point {
			return new Point(x, y);
		}
		
		public function get position():Point {
			return getPosition();
		}
		
		public function enable():void {
			_disabled = false;
			
			updateEnabled()
		}
		
		public function disable():void {
			_disabled = true;
			
			updateEnabled();
		}
		
		public function setEnabled(value:Boolean):void {
			value ? enable() : disable();
		}
		
		protected function updateEnabled():void {
		}
	}
}