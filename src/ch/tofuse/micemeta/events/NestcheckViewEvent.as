package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.entities.LocationCheck;
	
	import flash.events.Event;
	
	public class NestcheckViewEvent extends Event
	{
		public static const ADD_LOCATION_CHECK:String = "addLocationCheck";
		
		private var _locationCheck:LocationCheck;
		
		public function get locationCheck():LocationCheck
		{
			return _locationCheck;
		}
		
		public function NestcheckViewEvent(type:String, locationCheck:LocationCheck, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new NestcheckViewEvent(type, locationCheck, bubbles, cancelable);
			
		}
	}
}