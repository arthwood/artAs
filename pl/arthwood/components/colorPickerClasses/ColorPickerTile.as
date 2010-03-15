package pl.arthwood.components.colorPickerClasses {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class ColorPickerTile extends MovieClip {
		private var _cpTable:ColorPickerTable;
		private var _colorTransform:ColorTransform;
		
		public function ColorPickerTile() {
			_cpTable = ColorPickerTable(parent.parent);
			_colorTransform = transform.colorTransform;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onTileMouseDown);
			addEventListener(MouseEvent.MOUSE_OVER, onTileMouseOver);
		}
		
		private function onTileMouseDown(e_:MouseEvent):void {
			_cpTable.onTile(this);
		}
		
		private function onTileMouseOver(e_:MouseEvent):void {
			_cpTable.onTileOver(this);
		}
		
		public function get color():uint {
			return _colorTransform.color;
		}
	}
}