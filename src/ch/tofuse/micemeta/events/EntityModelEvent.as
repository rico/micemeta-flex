package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	import flash.events.Event;
	
	public class EntityModelEvent extends Event
	{
		public static const ENTITIES_LOADED:String = "entitiesLoaded";
		public static const LITTER_ENTITIES_LOADED:String = "litterEntitiesLoaded";
		public static const OTHER_LOCATION_ENTITIES_LOADED:String = "otherLocationEntitiesLoaded";
		public static const BOX_ENTITIES_LOADED:String = "boxEntitiesLoaded";
		
		private var _model:IEntityModelInterface;
		
		public function get model():IEntityModelInterface
		{
			return _model;
		}
		
		public function EntityModelEvent(type:String, model:IEntityModelInterface,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_model = model;
			
		}
		
		override public function clone():Event
		{
			return new EntityModelEvent(type, model, bubbles, cancelable);
			
		}
	}
}