package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.AbstractEntityModel;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	
	import mx.effects.IAbstractEffect;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AbstractComponentMediator extends Mediator
	{
		private var _view:AbstractComponentView;
		private var _model:IEntityModelInterface;
		
		public function AbstractComponentMediator()
		{
			super();
		}
		
		public function set view( v:AbstractComponentView ):void
		{
			_view = v;	
		}
		
		public function get view():AbstractComponentView
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
			_view.entities = _model.repository.entities;
			_view.repository = _model.repository;
			
			addViewListener( EntityMediatorEvent.ENTITY_PERSIST, handlePersist );
			addViewListener( EntityMediatorEvent.ENTITY_REMOVE, handleRemove );
			
			addViewListener( EntityManagerEvent.FLUSH, handleFlush );
			addViewListener( EntityManagerEvent.ROLLBACK, rollbackHandler );
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
		
		protected function rollbackHandler():void
		{
			_model.entityManager.rollback();
		}
	}
}