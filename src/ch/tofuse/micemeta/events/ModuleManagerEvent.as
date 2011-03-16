package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.views.ContentNavigator;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	
	import flash.events.Event;
	
	public class ModuleManagerEvent extends Event
	{
		public static const INIT_MODULES:String = "initModules";
		
		public var modules:Vector.<IContent>;
		public var moduleNavigator:ContentNavigator;
		
		public function ModuleManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}