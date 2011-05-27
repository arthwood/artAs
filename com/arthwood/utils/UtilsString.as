package com.arthwood.utils {
	import com.arthwood.utils.UtilsArray;
	
	public class UtilsString {
		public static function strip(str:String):String {
			return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
		}
		
		public static function lastChar(str:String):String {
			return str.substr(str.length - 1, 1);
		}
		
		public static function capitalize(str:String):String {
			return str.split(' ').map(capitalizeCallback).join();
		}
		
		private static function capitalizeCallback(i:String, idx:uint, arr:Array):String {
			return i.charAt(0).toUpperCase() + i.substr(1);
		}
		
		public static function toS(str:String):String {
			return str || '';
		}
		
		public static function isEmpty(str:String):Boolean {
			return str.replace(/\s/g, '').length == 0;
		}
		
		public static function addZeros(str:String, length:uint, right:Boolean = false):String {
			var zeros:String = getMultiPattern('0', length - str.length);
			
			return right ? str + zeros : zeros + str;
		}
		
		public static function getMultiPattern(pattern:String, n:uint):String {
			var str:String = '';
			
			while (n-- > 0) {
				str += pattern;
			}
			
			return str;
		}
		
		public static function underscore(str:String):String {
			return str.charAt(0).toLowerCase() + str.substr(1).replace(/[A-Z]/g, underscoreConvertion);
		}
		
		private static function underscoreConvertion(matchedSubstring:String, capturedMatch1:String, index:int):String {
			return '_' + matchedSubstring.toLowerCase();
		}
		
		public static function pluralize(str:String):String {
			var lastCharIdx:uint = str.length - 1;
			var lastChar:String = str.charAt(lastCharIdx);
			
			return (lastChar == 'y') ? (str.substr(0, lastCharIdx) + 'ies') : str + ((lastChar == 's') ? 'es' : 's');
		}
	}
}