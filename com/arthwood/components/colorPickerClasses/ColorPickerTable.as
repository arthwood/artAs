package com.arthwood.components.colorPickerClasses {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import com.arthwood.components.ColorPicker;
	import com.arthwood.components.colorPickerClasses.ColorPickerTile;
	import com.arthwood.components.Component;
	import com.arthwood.utils.UtilsString;

	public class ColorPickerTable extends Component {
		public var mcColor:MovieClip;
		public var mcTable:MovieClip;
		public var tfColor:TextField;
		
		private var _cp:ColorPicker;
		private var _colorTransform:ColorTransform;
		
		public function ColorPickerTable() {
			_cp = ColorPicker(parent);
			_colorTransform = mcColor.transform.colorTransform;
			mcColor.addEventListener(MouseEvent.CLICK, onMcColorClick);
		}
		
		public function onTile(tile_:ColorPickerTile):void {
			_cp.onTile(tile_.color);
			visible = false;
		}
		
		public function onTileOver(tile_:ColorPickerTile):void {
			setColor(tile_.color);
		}
		
		private function onBtnColorOver():void {
			setColor(_colorTransform.color);
		}
		
		private function setColor(c_:uint):void {
			_colorTransform.color = c_;
			setColorText(c_);
			_cp.color = c_;
		}
		
		private function onMcColorClick(e_:MouseEvent):void {
			visible = false;
		}
		
		private function setColorText(color_:uint):void {
			tfColor.text = '#' + UtilsString.addZeros(color_.toString(16), 6);
		}
		
		public function toggle():void {
			visible = !visible;
		}
	}
}