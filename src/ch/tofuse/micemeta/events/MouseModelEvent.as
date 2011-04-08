package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class MouseModelEvent extends Event
	{
		public static const ACTIVE_MICE_LOADED:String = "activeMiceLoaded";
		
		public function MouseModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new MouseModelEvent(type,bubbles,cancelable);
		}
	}
}