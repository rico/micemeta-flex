package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class EntityManagerEvent extends Event
	{
		public static const FLUSH:String = "flush";
		public static const ROLLBACK:String = "rollback";
		public static const CHECK_PENDING_CHANGES:String = "checkPendingChanges";
		
		public function EntityManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new EntityManagerEvent(type, bubbles, cancelable);
			
		}
	}
}