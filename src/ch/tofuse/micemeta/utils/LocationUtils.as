package ch.tofuse.micemeta.utils
{
	import ch.tofuse.micemeta.entities.BoxCheckEntity;
	import ch.tofuse.micemeta.entities.BoxEntity;
	import ch.tofuse.micemeta.entities.OtherLocationCheckEntity;
	import ch.tofuse.micemeta.entities.OtherLocationEntity;
	
	import mx.controls.dataGridClasses.DataGridColumn;

	public class LocationUtils
	{
		public static function locationCheckLabelFunction( item:Object, column:DataGridColumn ):String
		{
			if( item is OtherLocationCheckEntity ) {
				return OtherLocationCheckEntity(item).otherLocation.code + " - " + OtherLocationCheckEntity(item).otherLocation.description;
			}
			
			if( item is BoxCheckEntity ) {
				return "Box " + BoxCheckEntity(item).box.id;
			}
			
			return "(no location associated)";
		}
		
		public static function locationLabelFunction( item:Object, column:DataGridColumn = null ):String
		{
			if( item is OtherLocationEntity ) {
				return OtherLocationEntity(item).code + " - " + OtherLocationEntity(item).description;
			}
			
			if( item is BoxEntity ) {
				return "Box " + BoxEntity(item).id;
			}
			
			return item.id;
		}
	}
}