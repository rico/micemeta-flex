package ch.tofuse.micemeta.utils
{
	import ch.tofuse.micemeta.entities.Litter;
	
	import mx.controls.dataGridClasses.DataGridColumn;

	public class LitterUtils
	{
		
		
		public static function calculateLitterAgeLabelFunction( litter:Litter, column:DataGridColumn = null ):String
		{
			return (DateUtils.dateDiffInDays( new Date(), litter.first_found_date ) + litter.first_found_age).toString();
		}
	}
}