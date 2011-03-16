package ch.tofuse.micemeta.managers
{
	import ch.tofuse.micemeta.entities.Box;
	import ch.tofuse.micemeta.entities.Mouse;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	import mx.utils.ArrayUtil;
	
	import org.davekeen.flextrine.orm.Query;
	import org.davekeen.flextrine.util.QueryUtil;

	public class MouseManager extends EntityManagerBase
	{
		
		private var _rfidData:ArrayCollection;
		
		public function MouseManager()
		{
			super( Mouse );
		}
		
		[Bindable(Event="rfidDataChange")]
		public function get rfidData():ArrayCollection
		{
			/*if( !_rfidData && !loading ) {
				_em.select( 
					new Query("SELECT m FROM " + QueryUtil.getDQLClass( cls ) + " m WHERE m.data_count > :data_count AND m.last > DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)",{data_count: 100}) 
				).addResponder( 
					new AsyncResponder(onGetRfidDataResult, onDqlSelectFault) 
				);
				
				busy = true;
			}
			
			return _rfidData;*/
			return new ArrayCollection();
			
		}
		
		private function onGetRfidDataResult(result:Object, token:Object):void {
			_rfidData = new ArrayCollection( result.result as Array );
			dispatchEvent( new Event("rfidDataChange") );
			busy = false;
		}
		
	}
}