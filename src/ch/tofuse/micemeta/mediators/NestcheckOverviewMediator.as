package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.entities.NestCheckEntity;
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.events.NestcheckModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.BoxModel;
	import ch.tofuse.micemeta.models.NestcheckModel;
	import ch.tofuse.micemeta.models.OtherLocationModel;
	import ch.tofuse.micemeta.utils.DateUtils;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckOverview;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.davekeen.flextrine.orm.EntityRepository;
	
	public class NestcheckOverviewMediator extends AbstractComponentMediator
	{
		
		private var _view:NestcheckOverview;
		private var _nestcheckModel:NestcheckModel;
		
		[Inject]
		override public function set view( v:AbstractComponentView ):void
		{
			_view = NestcheckOverview( v );	
			super.view = _view;
		}
		
		[Inject(name="NestcheckModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			_nestcheckModel = NestcheckModel( m );
			super.model = m;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener( _nestcheckModel.eventDispatcher, NestcheckModelEvent.LOCATIONS_LOADED, locationEntitiesLoadedHandler, EntityModelEvent );
			_view.locationsData = _nestcheckModel.locations;
			_view.disabledNestcheckDates = disabledNestcheckDates();
			
		}

		private function disabledNestcheckDates():Array
		{
			var disabledDates:Array = [];
			
			for each ( var nc:NestCheckEntity in _nestcheckModel.repository.entities ) {
				disabledDates.push( nc.checkdate );
			}
			
			disabledDates.push( {rangeStart: new Date( new Date().getTime() + DateUtils.MILLISECONDS_PER_DAY) } );
			
			return disabledDates;
			
		}

		private function locationEntitiesLoadedHandler( e:NestcheckModelEvent ):void
		{
			_view.locationsData = _nestcheckModel.locations;
		}
		
		override public function get view():AbstractComponentView
		{
			return _view;
		}
		
	}
}