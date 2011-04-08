package ch.tofuse.micemeta.models
{
	import ch.tofuse.micemeta.entities.NestCheckEntity;
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.events.NestcheckModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	import mx.collections.ArrayCollection;

	public class NestcheckModel extends AbstractEntityModel
	{
		private var _otherLocationModel:OtherLocationModel;
		private var _boxModel:BoxModel;
		private var _locations:ArrayCollection = new ArrayCollection();
		
		private var _otherLocationsLoaded:Boolean;
		private var _boxesLoaded:Boolean;
		
		public function NestcheckModel()
		{
			super( NestCheckEntity );
		}
		

		public function get otherLocationModel():IEntityModelInterface
		{
			return _otherLocationModel;
		}
		
		[Inject(name="OtherLocationModel")]
		public function set otherLocationModel(value:IEntityModelInterface):void
		{
			_otherLocationModel = OtherLocationModel( value );
			_otherLocationsLoaded = false;
			eventMap.mapListener( _otherLocationModel.eventDispatcher, EntityModelEvent.OTHER_LOCATION_ENTITIES_LOADED, locationEntitiesLoadedHandler, EntityModelEvent );
			_otherLocationModel.loadAll( new EntityModelEvent( EntityModelEvent.OTHER_LOCATION_ENTITIES_LOADED, _otherLocationModel) );
			
		}

		public function get boxModel():IEntityModelInterface
		{
			return _boxModel;
		}
		
		[Inject(name="BoxModel")]
		public function set boxModel(value:IEntityModelInterface):void
		{
			_boxModel = BoxModel( value );
			_boxesLoaded = false;
			eventMap.mapListener( _boxModel.eventDispatcher, EntityModelEvent.BOX_ENTITIES_LOADED, locationEntitiesLoadedHandler, EntityModelEvent );
			_boxModel.loadAll( new EntityModelEvent( EntityModelEvent.BOX_ENTITIES_LOADED, _boxModel) );
		}

		public function get locations():ArrayCollection
		{
			return _locations;
		}
		
		private function locationEntitiesLoadedHandler( e:EntityModelEvent ):void
		{
			if( e.model is OtherLocationModel ) {
				_locations.addAll( e.model.repository.entities );
				_otherLocationsLoaded = true;
			} else if ( e.model is BoxModel ) {
				_locations.addAll( e.model.repository.entities );				
				_boxesLoaded = true;
			}
			
			if( _boxesLoaded && _otherLocationsLoaded ) {
				eventDispatcher.dispatchEvent( new NestcheckModelEvent( NestcheckModelEvent.LOCATIONS_LOADED) );
			}
		}
		
	}
}