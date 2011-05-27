package com.arthwood.utils {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class UtilsTextField {
		public static function bold(tf_:TextField, bold_:Boolean):void {
			changeTextFormatProp(tf_, "bold", bold_);
		}
		
		public static function font(tf_:TextField, font_:String):void {
			changeTextFormatProp(tf_, "font", font_);
		}
		
		public static function size(tf_:TextField, size_:Number):void {
			changeTextFormatProp(tf_, "size", size_);
		}
		
		public static function color(tf_:TextField, color_:Number):void {
			changeTextFormatProp(tf_, "color", color_);
		}
		
		public static function align(tf_:TextField, align_:String):void {
			changeTextFormatProp(tf_, "align", align_);
		}
		
		public static function url(tf_:TextField, url_:String):void {
			changeTextFormatProp(tf_, "url", url_);
		}
		
		public static function changeTextFormatProp(tf_:TextField, prop_:String, value_:Object):void {
			var vTextFormat:TextFormat = tf_.getTextFormat();
			
			vTextFormat[prop_] = value_;
			tf_.setTextFormat(vTextFormat);
		}
		
		public static function setTabIndex(... args):void {
			args.forEach(assignTabIndex);
		}

		private static function assignTabIndex(i_:TextField, idx_:uint, arr_:Array):void {
			i_.tabIndex = idx_;
		}

	}
}