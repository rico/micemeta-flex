package ch.tofuse.micemeta.utils
{
	public class DateUtils
	{
		public static const MILLISECONDS_PER_DAY:uint = 1000 * 60 * 60 * 24;
		public static const ACTIVE_MOUSE_THRESHOLD:uint = 1000 * 60 * 60 * 24 * 200; // 200 days
		
		public static function dateDiffInDays( fromDate:Date, toDate:Date ):uint
		{
			return Math.abs( Math.round( (new Date(  toDate.getTime() - ( fromDate).getTime() ).time / MILLISECONDS_PER_DAY) + 1 ) );
		}
		
		public static function halfYearAhedMysql( ):String
		{
			return new Date(new Date().getTime() - 200 * MILLISECONDS_PER_DAY).toString();
		}
	}
}