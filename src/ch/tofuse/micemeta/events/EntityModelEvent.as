package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	import flash.events.Event;
	
	public class EntityModelEvent extends Event
	{
		public static const ENTITIES_LOADED:String = "entitiesLoaded";
		
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