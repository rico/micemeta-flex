package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class EntityEvent extends Event
	{
		public static const ADD_ENTITY:String = "addEntity";
		public static const PERSIST_ENTITY:String = "persistEntity";
		public static const REMOVE_ENTITY:String = "removeEntity";
		public static const EDIT_ENTITY:String = "editEntity";
		
		public function EntityEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new EntityEvent(type, bubbles, cancelable);
		}
	}
}