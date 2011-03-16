package ch.tofuse.micemeta.helpers
{
	import mx.collections.ArrayCollection;

	public class DataHelpers
	{
		public static function getItemIndexByPropertyValue( prop:String, value:String, data:ArrayCollection ):uint
		{
			for (var i:uint ; i < data.length; i++ ) {
				
				if( data[ i ][ prop ] == value ) {
					return i;
				}
			}
			
			return 0;
		}	
		
	}
}