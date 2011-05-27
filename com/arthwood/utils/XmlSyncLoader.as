package com.arthwood.utils {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	* ...
	* @author Artur Bilski
	*/
	public class XmlSyncLoader extends EventDispatcher {
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		private var _resourcesLoaded:uint = 0;
		private var _urls:Array;
		private var _data:Array;
		
		public function XmlSyncLoader() {
			_urlRequest = new URLRequest();
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onResourceLoad);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onResourceLoadError);
		}
		
		public function load(urls_:Array):void {
			_urls = urls_;
			_resourcesLoaded = 0;
			_data = new Array();
			
			loadNextOrFinish();
		}
		
		private function loadNext():void {
			_urlRequest.url = _urls[_resourcesLoaded];
			_urlLoader.load(_urlRequest);
			_resourcesLoaded++;
		}
		
		private function onResourceLoad(e_:Event):void {
			var vData:String = URLLoader(e_.currentTarget).data;
			var vXml:XML = new XML(vData);
			
			_data.push(vXml);
			loadNextOrFinish();
		}
		
		private function onResourceLoadError(e_:IOErrorEvent):void {
			loadNextOrFinish();
		}
		
		private function loadNextOrFinish():void {
			if (_resourcesLoaded == _urls.length) {
				onAllLoaded();
			}
			else {
				loadNext();
			}
		}
		
		private function onAllLoaded():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get data():Array {
			return _data;
		}
	}
}