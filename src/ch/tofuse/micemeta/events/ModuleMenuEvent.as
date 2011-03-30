package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.views.ContentNavigatorView;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	
	import flash.events.Event;
	
	public class ModuleMenuEvent extends Event
	{
		public static const DISABLE_FILTER:String = "disableFilter";
		public static const ENABLE_FILTER:String = "enableFilter";
		
		public static const DISABLE_LIST:String = "disableList";
		public static const ENABLE_LIST:String = "enableList";
		
		public static const DISABLE_OPTIONS:String = "disableOptions";
		public static const ENABLE_OPTIONS:String = "enableOptions";
		
		public static const DISABLE_MENU:String = "disableMenu";
		public static const ENABLE_MENU:String = "enableMenu";
		
		public static const DISABLE_CONTROLS:String = "disableControls";
		public static const ENABLE_CONTROLS:String = "enableControls";		
		
		
		public function ModuleMenuEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}