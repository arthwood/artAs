package pl.arthwood.utils {
	import pl.arthwood.utils.UtilsArray;
	
	public class UtilsString {
		public static function capitalize(str_:String):String {
			return str_.split(' ').map(capitalizeCallback).join();
		}
		
		private static function capitalizeCallback(i_:String, idx_:uint, arr_:Array):String {
			return i_.charAt(0).toUpperCase() + i_.substr(1);
		}
		
		public static function toS(str_:String):String {
			return str_ || '';
		}
		
		public static function isEmpty(str_:String):Boolean {
			return str_.replace(/\s/g, '').length == 0;
		}
		
		public static function addZeros(str_:String, length_:uint, right_:Boolean = false):String {
			var vZeros:String = getMultiPattern('0', length_ - str_.length);
			
			return right_ ? str_ + vZeros : vZeros + str_;
		}

		public static function getMultiPattern(pattern_:String, n_:uint):String {
			var vStr:String = '';
			
			while (n_-- > 0) {
				vStr += pattern_;
			}
			
			return vStr;
		}
		
		public static function underscore(v_:String):String {
			return v_.charAt(0).toLowerCase() + v_.substr(1).replace(/[A-Z]/g, underscoreConvertion);
		}
		
		private static function underscoreConvertion(matchedSubstring_:String, capturedMatch1_:String, index_:int):String {
			return '_' + matchedSubstring_.toLowerCase();
		}
		
		public static function pluralize(v_:String):String {
			var vLastCharIdx:uint = v_.length - 1;
			var vLastChar:String = v_.charAt(vLastCharIdx);

			return (vLastChar == 'y') ? (v_.substr(0, vLastCharIdx) + 'ies') : v_ + ((vLastChar == 's') ? 'es' : 's');
		}
	}
}