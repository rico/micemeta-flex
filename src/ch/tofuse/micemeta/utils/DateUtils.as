package ch.tofuse.micemeta.utils
{
	public class DateUtils
	{
		public static const MILLISECONDS_PER_DAY:uint = 1000 * 60 * 60 * 24;
		
		public static function dateDiffInDays( fromDate:Date, toDate:Date ):uint
		{
			return Math.abs( Math.round( (new Date(  toDate.getTime() - ( fromDate).getTime() ).time / MILLISECONDS_PER_DAY) + 1 ) );
		}
	}
}