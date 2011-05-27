package com.arthwood.utils {
	import flash.utils.getTimer;

	public class UtilsTime {
		private static var _t1:Number = 0;
		private static var _t2:Number = 0;
		
		public static function get ms():Number {
			return getTimer();
		}
		
		public static function fromYM(str, separator = '/') {
			var arr = str.split(separator);
			
			return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1);
		}
		
		public static function fromYMD(str, separator = '/') {
			var arr = str.split(separator);
			
			return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, parseInt(arr[2], 10));
		}
		
		public static function miliToHMSM(mili_:Number):String {
			var mili:Number = mili_ % 1000;
			var totalSeconds:Number = (mili_ - mili) / 1000;
			var seconds:Number = totalSeconds % 60;
			var totalMinutes:Number = (totalSeconds - seconds) / 60;
			var minutes:Number = totalMinutes % 60;
			var totalHours:Number = (totalMinutes - minutes) / 60;
			var hours:Number = totalHours;
			var az:Function = UtilsString.addZeros;
			
			return hours.toString() + ':' + az(minutes.toString(), 2) + ":" + az(seconds.toString(), 2) + '.' + az(mili.toString(), 3);
		}
		
		public static function miliToMSM(mili_:Number):String {
			var mili:Number = mili_ % 1000;
			var totalSeconds:Number = (mili_ - mili) / 1000;
			var seconds:Number = totalSeconds % 60;
			var totalMinutes:Number = (totalSeconds - seconds) / 60;
			var minutes:Number = totalMinutes;
			var az:Function = UtilsString.addZeros;
			
			return minutes.toString() + ":" + az(seconds.toString(), 2) + '.' + az(mili.toString(), 3);
		}
		
		public static function dateToHMS(date:Date, separator:String = ':'):String {
			var az:Function = UtilsString.addZeros;
			var hours:String = date.getHours().toString();
			var minutes:String = az(date.getMinutes().toString(), 2);
			var seconds:String = az(date.getSeconds().toString(), 2);
			
			return hours + separator + minutes + separator + seconds;
		}
		
		public static function dateToYM(date:Date, separator:String = '/'):String {
			var az:Function = UtilsString.addZeros;
			var year:String = date.getFullYear().toString();
			var month:String = az((date.getMonth() + 1).toString(), 2);
			
			return year + separator + month;
		}
		
		public static function dateToYMD(date:Date, separator:String = '/'):String {
			var az:Function = UtilsString.addZeros;
			var year:String = date.getFullYear().toString();
			var month:String = az((date.getMonth() + 1).toString(), 2);
			var day:String = az(date.getDate().toString(), 2);
			
			return year + separator + month + separator + day;
		}
		
		public static function minutesToHM(minutes:Number, separator:String = ':'):String {
			return Math.floor(minutes/60) + separator + UtilsString.addZeros(String(minutes % 60), 2);
		}
		
		public static function HMToMinutes(time:String):Number {
			time = UtilsString.strip(time);
			
			var arr:Array = time.split(':');
			var hour:Number = Number(arr[0])
			var minute:Number = Number(arr[1]);
			
			return 60 * (isNaN(hour)? 0 : hour) + (isNaN(minute)? 0 : minute);
		}
		
		public static function HMDecToMinutes(time:String):Number {
			time = UtilsString.strip(time);
			
			return Math.round(60 * Number(time));
		}
		
		public static function copyDate(date:Date):Date {
			return new Date(date.getTime());
		}
		
		public static function getDateShifted(date:Date, days:Number):Date {
			date = copyDate(date);
			
			date.setDate(date.getDate() + days);
			
			return date;
		}
		
		public static function stripDayTime(date:Date):Date {
			return new Date(date.getFullYear(), date.getMonth(), date.getDate());
		}
		
		public static function get interval():Number {
			var interval:Number = (_t2 = ms) - _t1;
			
			_t1 = _t2;
			
			return interval;
		}
		
		public static function intervalMsg(message:String):String {
			return String(interval) + 'ms -> ' + message;
		}
	}
}