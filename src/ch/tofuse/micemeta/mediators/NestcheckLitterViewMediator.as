package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.LitterModel;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckLitterView;
	
	import flash.events.Event;

	public class NestcheckLitterViewMediator extends AbstractComponentMediator
	{
		
		private var _view:NestcheckLitterView;
		private var _model:IEntityModelInterface;
		
		[Inject]
		override public function set view( v:AbstractComponentView ):void
		{
			_view = NestcheckLitterView(v);	
		}
		
		[Inject(name="LitterModel")]
		override public function set model( m:IEntityModelInterface ):void
		{
			//_model = m;
			super.model = m;
		}
		
		override public function onRegister():void
		{
			_view.repository = model.repository;
			_view.entities = model.repository.entities;
			
			addViewListener( EntityMediatorEvent.ENTITY_PERSIST, handlePersist );
			addViewListener( EntityMediatorEvent.ENTITY_REMOVE, handleRemove );
			
			addViewListener( EntityManagerEvent.FLUSH, handleFlush );
			addViewListener( EntityManagerEvent.ROLLBACK, rollbackHandler );
			
			litterEntitiesLoadedHandler();
			
			eventMap.mapListener( model.eventDispatcher, EntityModelEvent.LITTER_ENTITIES_LOADED, litterEntitiesLoadedHandler, EntityModelEvent );
			model.loadAll( new EntityModelEvent( EntityModelEvent.LITTER_ENTITIES_LOADED, LitterModel(model) ) );
			
		}	
			
		protected function litterEntitiesLoadedHandler( e:EntityModelEvent = null ):void
		{
			_view.existingLittersData = model.repository.entities;
			_view.proposeLitterIdentifier();
		}
	}
}