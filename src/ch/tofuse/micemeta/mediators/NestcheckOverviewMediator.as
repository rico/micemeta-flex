package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckOverview;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.davekeen.flextrine.orm.EntityRepository;

	public class NestcheckOverviewMediator extends AbstractComponentMediator
	{
		
		private var _view:NestcheckOverview;
		
		private var _otherLocationModel:IEntityModelInterface;
		private var _boxModel:IEntityModelInterface;
		private var _boxCheckModel:IEntityModelInterface;
		private var _otherLocationCheckModel:IEntityModelInterface;
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// location entities
			eventMap.mapListener( _boxModel.eventDispatcher, EntityModelEvent.ENTITIES_LOADED, locationEntitiesLoadedHandler, EntityModelEvent );
			eventMap.mapListener( _otherLocationModel.eventDispatcher, EntityModelEvent.ENTITIES_LOADED, locationEntitiesLoadedHandler, EntityModelEvent );
			
			_otherLocationModel.loadAll( true );
			_boxModel.loadAll( true );
			
			if( _view.nestcheckDateValid() ) {
				if( model.repository.getEntityState( _view.nestcheck ) == EntityRepository.STATE_NEW ) {
					_view.nestcheck.checkdate = _view.nestcheckDate.selectedDate;
					model.persist( _view.nestcheck );
				}
			}
			
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
		
		protected function locationEntitiesLoadedHandler( e:EntityModelEvent ):void
		{
			_view.locationsData.addAll( e.model.repository.entities );
		}
		
	}
}