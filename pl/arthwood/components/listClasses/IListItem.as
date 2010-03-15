package pl.arthwood.components.listClasses {
	import flash.events.IEventDispatcher;
	
	public interface IListItem extends IEventDispatcher {
		function createItem():ListItem;
		function get label():String;
		function get value():Object;
	}
}