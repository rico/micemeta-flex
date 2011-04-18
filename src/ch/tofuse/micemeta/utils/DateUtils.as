package ch.tofuse.micemeta.utils
{
	import ch.tofuse.micemeta.formatters.GeneralDateFormatter;
	
	import mx.formatters.DateFormatter;

	public class DateUtils
	{
		public static const MILLISECONDS_PER_DAY:uint = 1000 * 60 * 60 * 24;
		public static const ACTIVE_MOUSE_THRESHOLD:uint = 1000 * 60 * 60 * 24 * 200; // 200 days
		public static const MYSQL_DATE_FORMAT:String = 'YYYY-MM-DD';
		
		public static function dateDiffInDays( fromDate:Date, toDate:Date ):uint
		{
			return Math.abs( Math.round( (new Date(  toDate.getTime() - ( fromDate).getTime() ).time / MILLISECONDS_PER_DAY) + 1 ) );
		}
		
		public static function activeMouseThreshold( ):String
		{
			
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = MYSQL_DATE_FORMAT;
			
			return dateFormatter.format( new Date(new Date().getTime() - 200 * MILLISECONDS_PER_DAY) );
		}
		
		public static function toGeneralDateFormat( nestcheckDate:Date ):String
		{
			
			var dateFormatter:GeneralDateFormatter = new GeneralDateFormatter();
			
			return dateFormatter.format( nestcheckDate );
		}
	}
}