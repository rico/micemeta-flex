package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.entities.ILocationCheck;
	
	import flash.events.Event;
	
	public class NestcheckViewEvent extends Event
	{
		public static const ADD_LOCATION_CHECK:String = "addLocationCheck";
		public static const CLOSE_LOCATION_CHECK:String = "closeLocationCheck";
		public static const EDIT_LOCATION_CHECK:String = "editLocationCheck";
		public static const SHOW_LOCATION_CHECK:String = "showLocationCheck";
		
		private var _locationCheck:ILocationCheck;
		
		public function get locationCheck():ILocationCheck
		{
			return _locationCheck;
		}
		
		public function NestcheckViewEvent(type:String, locationCheck:ILocationCheck, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_locationCheck = locationCheck;
		}
		
		override public function clone():Event
		{
			return new NestcheckViewEvent(type, locationCheck, bubbles, cancelable);
			
		}
	}
}