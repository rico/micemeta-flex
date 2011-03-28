package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.AbstractEntityModel;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	
	import mx.effects.IAbstractEffect;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AbstractEntityMediator extends Mediator
	{
		[Inject]
		public var view:AbstractComponentView;
		
		protected var _model:IEntityModelInterface;
		
		public function AbstractEntityMediator()
		{
			super();
		}
		
		public function set model( m:IEntityModelInterface ):void
		{
			_model = m;
		}
		
		override public function onRegister():void
		{
			view.entities = _model.repository.entities;
			view.repository = _model.repository;
			
			addViewListener( EntityMediatorEvent.ENTITY_PERSIST, handlePersist );
			addViewListener( EntityMediatorEvent.ENTITY_REMOVE, handleRemove );
			addViewListener( EntityManagerEvent.FLUSH, handleFlush );
		}
		
		protected function handlePersist( e:EntityMediatorEvent ):void
		{
			_model.persist( e.entity );
			
			if( e.flush ) {
				_model.flush();
			}
		}
		
		protected function handleRemove( e:EntityMediatorEvent ):void 
		{
			_model.remove( e.entity );
			
			if( e.flush ) {
				_model.flush();
			}
		}
		
		protected function handleFlush( e:EntityManagerEvent ):void 
		{
			_model.flush();
		}
	}
}