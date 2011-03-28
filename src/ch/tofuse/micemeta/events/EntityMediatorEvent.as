package ch.tofuse.micemeta.events
{
	import flash.events.Event;

	public class EntityMediatorEvent extends Event
	{
		public static const ENTITY_REMOVE:String = "entityRemove";
		public static const ENTITY_PERSIST:String = "entityPersist";
		
		private var _entity:*;
		private var _flush:Boolean;
		
		public function get entity():*
		{
			return _entity;
		}
		
		public function get flush():Boolean
		{
			return _flush;
		}

		
		public function EntityMediatorEvent(type:String, entity:*, flush:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_entity = entity;
			_flush = flush;
		}
		
		override public function clone():Event
		{
			return new EntityMediatorEvent(type, entity, flush, bubbles, cancelable);
			
		}
	}
}