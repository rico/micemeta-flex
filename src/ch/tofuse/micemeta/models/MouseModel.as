package ch.tofuse.micemeta.models
{
	import ch.tofuse.micemeta.entities.MouseEntity;
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.events.MouseModelEvent;
	import ch.tofuse.micemeta.utils.DateUtils;
	
	import flash.events.Event;
	
	import flashx.textLayout.events.ModelChange;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	
	import org.davekeen.flextrine.orm.Query;
	import org.davekeen.flextrine.util.QueryUtil;

	public class MouseModel extends AbstractEntityModel
	{
		
		private var _activeMice:ArrayCollection;
		
		public function MouseModel()
		{
			super( MouseEntity );
		}
		
		override public function loadAll( eventToDispatchWhenLoaded:EntityModelEvent ):void
		{
			if( !_entitiesLoading && !_entititesLoaded ) {
				_entitiesLoading = true;
				_eventToDispatchWhenLoaded = eventToDispatchWhenLoaded;
				//repository.loadAll().addResponder( new AsyncResponder(onEntitiesLoadResult, onLoadFault) );
			} 
		}
		
		[Bindable(Event="rfidDataChange")]
		public function get activeMice():ArrayCollection
		{
			
			if( !_activeMice ) {
				
				_activeMice = new ArrayCollection();
				//loadAll( new EntityModelEvent( EntityModelEvent.ACTIVE_MOUSE_ENTITIES_LOADED, this ) );
				
				entityManager.select( 
					new Query("SELECT m FROM " + QueryUtil.getDQLClass( cls ) + " m WHERE m.data_count > :data_count AND m.last > " + DateUtils.halfYearAhedMysql()  + ")",{data_count: 100}) 
					//new Query("SELECT m FROM " + QueryUtil.getDQLClass( cls ) + " m WHERE m.data_count > :data_count",{data_count: 10000})
				).addResponder( 
					new AsyncResponder(onGetRfidDataResult, onFault) 
				);
			}
			
			return _activeMice;
			
		}
		
		private function onGetRfidDataResult(result:Object, token:Object):void {
			_activeMice = new ArrayCollection( result.result as Array );
			dispatch( new MouseModelEvent( MouseModelEvent.ACTIVE_MICE_LOADED ) );
		}
	}
}