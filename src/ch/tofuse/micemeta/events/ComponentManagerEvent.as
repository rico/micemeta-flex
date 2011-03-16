package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.views.ContentNavigator;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	
	import flash.events.Event;
	
	public class ComponentManagerEvent extends Event
	{
		public static const INIT_COMPONENTS:String = "initComponents";
		
		public var components:Vector.<IContent>;
		public var componentNavigator:ContentNavigator;
		
		public function ComponentManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}