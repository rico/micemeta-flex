package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class NestcheckModelEvent extends Event
	{
		
		public static const LOCATIONS_LOADED:String = "locationsLoaded";
		
		public function NestcheckModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new Event(type, bubbles, cancelable);
		}
	}
}