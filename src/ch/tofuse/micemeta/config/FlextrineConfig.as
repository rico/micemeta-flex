package ch.tofuse.micemeta.config
{
	import org.davekeen.flextrine.orm.Configuration;

	public class FlextrineConfig extends Configuration
	{
		
		//public static const GATEWAY:String = "http://micemeta/flextrine/php/web/gateway.php?app=micemeta";
		public static const GATEWAY:String = "http://micemeta/flextrine-clone/php/web/gateway.php?app=micemeta";
		public static const ENTITY_TIME_TO_LIVE:Number = -1;
		
		public function FlextrineConfig():void
		{
			gateway = GATEWAY;
			entityTimeToLive = ENTITY_TIME_TO_LIVE;
		}
		
	}
}