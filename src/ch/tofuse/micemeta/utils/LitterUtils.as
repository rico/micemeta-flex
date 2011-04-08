package ch.tofuse.micemeta.utils
{
	import ch.tofuse.micemeta.entities.LitterCheckEntity;
	import ch.tofuse.micemeta.entities.LitterEntity;
	
	import mx.controls.dataGridClasses.DataGridColumn;

	public class LitterUtils
	{
		
		public static function calculateLitterAgeLabelFunction( litterCheck:LitterCheckEntity, column:DataGridColumn = null ):String
		{
			return (DateUtils.dateDiffInDays( new Date(), litterCheck.litter.first_found_date ) + litterCheck.litter.first_found_age).toString();
		}
		
		public static function litterCheckIdentifierLabelFunction( litterCheck:LitterCheckEntity, column:DataGridColumn ):String
		{
			return litterCheck.litter.identifier;
		}
		
		public static function litterLabelFunction( litter:LitterEntity ):String
		{
			return litter.identifier;
		}
		
	}
}