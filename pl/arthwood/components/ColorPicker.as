package pl.arthwood.components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import pl.arthwood.components.Component;
	import pl.arthwood.components.colorPickerClasses.ColorPickerTable;

	public class ColorPicker extends Component {
		public var table:ColorPickerTable;
		public var btn:MovieClip;
		
		private var _btnTransform:Transform;
		
		public function ColorPicker() {
			_btnTransform = MovieClip(btn.mcColor).transform;
			btn.addEventListener(MouseEvent.MOUSE_DOWN, onButton);
			table.visible = false;
			root.addEventListener(MouseEvent.CLICK, onRootMouseClick);
		}
		
		private function onRootMouseClick(e_:MouseEvent):void {
			if (table.visible && !hitTestPoint(e_.stageX, e_.stageY)) {
				table.visible = false;
			}
		}
		
		private function onButton(e_:MouseEvent):void {
			table.toggle();
		}
		
		public function onTile(color_:uint):void {
			color = color_;
			
			dispatchEvent(new Event(Event.SELECT));
		}
		
		public function get color():uint {
			return _btnTransform.colorTransform.color;
		}
		
		public function set color(color_:uint):void {
			var vColorTransform:ColorTransform = new ColorTransform();
			
			vColorTransform.color = color_;
			_btnTransform.colorTransform = vColorTransform;

		}
	}
}