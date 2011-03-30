package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckOverview;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	
	import mx.collections.ArrayCollection;

	public class NestcheckOverviewMediator extends AbstractEntityMediator
	{
		
		private var _view:NestcheckOverview;
		
		private var _otherLocationModel:IEntityModelInterface;
		private var _boxModel:IEntityModelInterface;
		
		override public function onRegister():void
		{
			super.onRegister();
			//addContextListener( EntityModelEvent.ENTITIES_LOADED, entitiesLoadedHandler );
			eventMap.mapListener( _boxModel.eventDispatcher, EntityModelEvent.ENTITIES_LOADED, entitiesLoadedHandler, EntityModelEvent );
			eventMap.mapListener( _otherLocationModel.eventDispatcher, EntityModelEvent.ENTITIES_LOADED, entitiesLoadedHandler, EntityModelEvent );
			
			_otherLocationModel.loadAll( true );
			_boxModel.loadAll( true );
			
			_view.validateCheckDate();
		}
		
		[Inject(name="NestcheckModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
		
		[Inject(name="OtherLocationModel")]
		public function set otherLocationModel(m:IEntityModelInterface):void
		{
			_boxModel = m;
		}
		
		[Inject(name="BoxModel")]
		public function set boxModel(m:IEntityModelInterface):void
		{
			_otherLocationModel = m;
		}
		
		[Inject]
		override public function set view( v:AbstractComponentView ):void
		{
			_view = NestcheckOverview( v );	
			super.view = _view;
		}
		
		override public function get view():AbstractComponentView
		{
			return _view;
		}
		
		protected function entitiesLoadedHandler( e:EntityModelEvent ):void
		{
			_view.locationsData.addAll( e.model.repository.entities );
		}
	}
}