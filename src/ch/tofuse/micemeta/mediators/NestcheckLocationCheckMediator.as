package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.events.MouseModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.MouseModel;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckLocationCheckView;

	public class NestcheckLocationCheckMediator extends AbstractComponentMediator
	{
		
		private var _view:NestcheckLocationCheckView;
		private var _model:MouseModel;
		
		[Inject]
		override public function set view( v:AbstractComponentView ):void
		{
			_view = NestcheckLocationCheckView(v);	
			super.view = _view;
		}
		
		[Inject(name="MouseModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			_model = MouseModel( m );
		}
		
		override public function get model():IEntityModelInterface
		{
			return _model;
		}
		
		override public function onRegister():void
		{			
			// rfid data
			//eventMap.mapListener( _model.eventDispatcher, MouseModelEvent.ACTIVE_MICE_LOADED, activeMiceLoadedHandler, MouseModelEvent );
			eventMap.mapListener( _model.eventDispatcher, EntityModelEvent.MOUSE_ENTITIES_LOADED, mouseEntitiesLoadedHandler, EntityModelEvent );
			_view.activeMice = _model.activeMice;
		}

		private function mouseEntitiesLoadedHandler( e:EntityModelEvent ):void
		{
			_view.activeMice = _model.repository.entities;
		}
		
		private function activeMiceLoadedHandler( e:MouseModelEvent ):void
		{
			_view.activeMice = _model.activeMice;
		}
		
		
		
	}
}