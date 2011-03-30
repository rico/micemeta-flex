package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.views.ContentNavigatorView;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	
	import flash.events.Event;
	
	public class ModuleManagerEvent extends Event
	{
		public static const INIT_MODULES:String = "initModules";
		
		public var modules:Vector.<IContent>;
		public var moduleNavigator:ContentNavigatorView;
		
		public function ModuleManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}