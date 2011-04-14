package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	
	import mx.events.CollectionEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AbstractModuleMediator extends Mediator
	{
		private var _view:AbstractModuleView;
		private var _model:IEntityModelInterface;
		
		public function AbstractModuleMediator()
		{
			super();
		}
		
		[Inject]
		public function set view( v:AbstractModuleView ):void
		{
			_view = v;	
		}
		
		public function get view():AbstractModuleView
		{
			return _view;
		}
		
		public function set model( m:IEntityModelInterface ):void
		{
			_model = m;
		}
		
		public function get model():IEntityModelInterface
		{
			return _model;
		}
		
		override public function onRegister():void
		{
			_view.repository = _model.repository;
			_view.entities = _model.repository.entities;
			//_model.repository.entities.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler );
			
			addViewListener( EntityMediatorEvent.ENTITY_REMOVE, removeEntityHandler, EntityMediatorEvent );
			
		}

		private function collectionChangeHandler(e:CollectionEvent):void
		{
			trace("change => " + e.kind);
		}
		
		protected function removeEntityHandler( e:EntityMediatorEvent ):void
		{
			model.remove( e.entity );
			
			if( e.flush ) {
				_model.flush();
			}
		}
		
	}
}