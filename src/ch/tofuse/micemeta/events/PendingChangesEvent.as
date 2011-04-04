package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	import flash.events.Event;
	
	public class PendingChangesEvent extends Event
	{
		public static const PENDING_CHANGES:String = "pendingChanges";
		
		private var _pendingChanges:Boolean;
		
		public function get pendingChanges():Boolean
		{
			return _pendingChanges;
		}
		
		public function PendingChangesEvent(type:String, pendingChanges:Boolean,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_pendingChanges = pendingChanges;
			
		}
		
		override public function clone():Event
		{
			return new PendingChangesEvent(type, pendingChanges, bubbles, cancelable);
		}
	}
}