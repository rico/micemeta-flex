package ch.tofuse.micemeta.entities {
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.davekeen.flextrine.orm.collections.PersistentCollection;

	[RemoteClass(alias="ch.tofuse.micemeta.entities.NestCheck")]
	[Entity]
	public class NestCheck extends NestCheckEntityBase {
		
		
		public function get locationChecks():PersistentCollection
		{
			if( box_checks && other_location_checks ) {
				return PersistentCollection( box_checks.addAll( other_location_checks ) );
			}
			
			if( box_checks ) {
				return box_checks;
			}
			
			if ( other_location_checks ) {
				return other_location_checks;
			}
			
			return new PersistentCollection();
		}
	}

}
