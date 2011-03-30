package ch.tofuse.micemeta.utils
{
	import mx.collections.ArrayCollection;

	public class DataUtils
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