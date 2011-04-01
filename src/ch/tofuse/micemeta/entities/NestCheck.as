package ch.tofuse.micemeta.entities {
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.davekeen.flextrine.orm.collections.PersistentCollection;

	[RemoteClass(alias="ch.tofuse.micemeta.entities.NestCheck")]
	[Entity]
	public class NestCheck extends NestCheckEntityBase {
		
		private var _locations:ArrayCollection;
		
		
		public function get locationChecks():ArrayCollection
		{
			return new  ArrayCollection( box_checks.toArray().concat( other_location_checks.toArray() ) )
		}
		
		public function get locations():ArrayCollection
		{
			_locations = new ArrayCollection();
			
			for each ( var bc:BoxCheck in box_checks ) {
				_locations.addItem( bc.box );
			}
			
			for each ( var olc:OtherLocationCheck in other_location_checks ) {
				locations.addItem( olc.otherLocation );
			}
			
			return _locations;
			
		}
	}

}
