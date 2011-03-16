package ch.tofuse.micemeta.formatters
{
	import mx.formatters.DateFormatter;
	
	public class GeneralDateFormatter extends DateFormatter
	{
		
		public static const DATE_FORMAT:String = "DD.MM.YYYY";
		
		public function GeneralDateFormatter()
		{
			super();
			formatString = DATE_FORMAT;
		}
	}
}