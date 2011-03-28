package ch.tofuse.micemeta.interfaces
{
	import ch.tofuse.micemeta.views.inputs.SearchTextInput;
	import ch.tofuse.micemeta.views.menus.modules.ModuleMenuContainer;
	import ch.tofuse.micemeta.views.menus.modules.ModuleMenuList;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerContent;
	
	import flash.display.DisplayObject;
	
	import mx.containers.HDividedBox;
	import mx.core.INavigatorContent;
	
	import spark.components.Group;
	import spark.components.NavigatorContent;

	public interface IContent
	{
		function get main():HDividedBox;
		function get menu():ModuleMenuContainer;
		function get content():ModuleContainerContent;
		function get menuEntriesList():ModuleMenuList;
		function get menuOptionsList():ModuleMenuList;
		function get menuEntriesFilter():SearchTextInput;
		
		[Bindable(Event="labelChange")]
		function get label():String;
		
		function asDisplayObject():DisplayObject;
		function asNavigatorContent():NavigatorContent;
		
		function set addInstanceOnStart(aios:Boolean):void
		[Bindable(Event="addInstanceOnStartChange")]
		function get addInstanceOnStart():Boolean
		
	}
}