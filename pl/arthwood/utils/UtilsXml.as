package pl.arthwood.utils {
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class UtilsXml {
		public static function mapChildren(xmlList_:XMLList, block_:Function):Array {
			var vResult:Array = new Array();
			
			for each (var i:XML in xmlList_) {
				vResult.push(block_(i));
			}
			
			return vResult;
		}
		
		public static function createSimpleElement(name_:String, value_:String):XML {
			return <{name_}>{value_}</{name_}>;
		}
	}
}