package pl.arthwood.utils {
	public class UtilsArray {
		public static function insertAt(arr_:Array, at_:uint, obj_:Object):Array {
			return arr_.slice(0, at_).concat(obj_).concat(arr_.slice(at_));
		}
		
		public static function removeItem(arr_:Array, item_:Object):void {
			var vIdx:uint;
			
			while ((vIdx = arr_.indexOf(item_)) != -1) {
				arr_.splice(vIdx, 1);
			}
		}
		
		public static function isInArray(arr_:Array, obj_:Object):Boolean {
			return arr_.indexOf(obj_) != -1;
		}
		
		public static function getLast(arr_:Array):Object {
			return arr_[arr_.length - 1];
		}
		
		public static function detect(arr_:Array, block_:Function):Object {
			return arr_.filter(block_)[0];
		}
	}
}