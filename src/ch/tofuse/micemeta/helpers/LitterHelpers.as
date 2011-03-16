package ch.tofuse.micemeta.helpers
{
	import ch.tofuse.micemeta.entities.Litter;
	
	import mx.controls.dataGridClasses.DataGridColumn;

	public class LitterHelpers
	{
		
		
		public static function calculateLitterAgeLabelFunction( litter:Litter, column:DataGridColumn = null ):String
		{
			return (DateHelpers.dateDiffInDays( new Date(), litter.first_found_date ) + litter.first_found_age).toString();
		}
	}
}