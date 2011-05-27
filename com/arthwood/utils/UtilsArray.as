package com.arthwood.utils {
	public class UtilsArray {
		public static function insertAt(arr:Array, at:uint, obj:Object):Array {
			return arr.slice(0, at).concat(obj).concat(arr.slice(at));
		}
		
		public static function removeItem(arr:Array, item:Object):void {
			var idx:uint;
			
			while ((idx = arr.indexOf(item)) != -1) {
				arr.splice(idx, 1);
			}
		}
		
		public static function includes(arr:Array, obj:Object):Boolean {
			return arr.indexOf(obj) != -1;
		}
		
		public static function getFirst(arr:Array):Object {
			return arr[0];
		}
		
		public static function getLast(arr:Array):Object {
			return arr[arr.length - 1];
		}
		
		public static function getBeforeLast(arr:Array):Object {
			return arr[arr.length - 2];
		}
		
		public static function detect(arr:Array, block:Function):Object {
			return arr.filter(block)[0];
		}
	}
}