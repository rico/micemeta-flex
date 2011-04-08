package ch.tofuse.micemeta.entities {
	
	import flash.events.Event;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	import mx.events.CollectionEvent;
	
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	
	[RemoteClass(alias="ch.tofuse.micemeta.entities.NestCheckEntity")]
	[Entity]
	public class NestCheckEntity extends NestCheckEntityEntityBase {
		
		private var _locations:ArrayCollection;
		private var _locationChecks:ArrayCollection;
		
		public function NestCheck():void
		{
			
			box_checks.addEventListener( CollectionEvent.COLLECTION_CHANGE, updateLocations );
			other_location_checks.addEventListener( CollectionEvent.COLLECTION_CHANGE, updateLocations )
			
			updateLocations();
		}
		
		[Bindable(event='locationsChanged')]
		public function get locationChecks():ArrayCollection
		{
			return _locationChecks;
		}
		
		[Bindable(Event="locationsChanged")]
		public function get locations():ArrayCollection
		{
			return _locations;
		}
		
		private function updateLocations( e:Event = null ):void
		{
			_locations = new ArrayCollection();
			_locationChecks = new ArrayCollection();
			
			for each ( var bc:BoxCheckEntity in box_checks ) {
				_locations.addItem( bc.box );
				_locationChecks.addItem( bc );
			}
			
			for each ( var olc:OtherLocationCheckEntity in other_location_checks ) {
				locations.addItem( olc.otherLocation );
				_locationChecks.addItem( olc );
			}
			
			dispatchEvent( new Event("locationsChanged") );
		}
		
	}

}
