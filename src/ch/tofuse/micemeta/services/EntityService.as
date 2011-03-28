package ch.tofuse.micemeta.services
{
	import ch.tofuse.micemeta.config.FlextrineConfig;
	
	import mx.managers.CursorManager;
	
	import org.davekeen.flextrine.orm.Configuration;
	import org.davekeen.flextrine.orm.EntityManager;
	import org.robotlegs.mvcs.Actor;
	
	public class EntityService extends Actor
	{
		private var _em:EntityManager;
		private var _configuration:Configuration;
		
		private var _busy:Boolean;
		
		public function EntityService()
		{
			_configuration = new FlextrineConfig();
			_em = EntityManager.getInstance();	
			_em.setConfiguration( _configuration );
		}
		
		public function persist( e:* , save:Boolean = false ):void
		{
			_em.persist( e );
			if( save ) {
				save();
			}
		}
		
		public function remove( e:*, save:Boolean = false ):void
		{
			entityManager.remove( e );
			
			if( save ) {
				save();
			}
		}
		
		public function save():void
		{
			_em.flush().addResponder( new AsyncResponder(onSaveResult, onFault) );
			//loadAll( true );
			busy = true;
			
		}
		
		protected function onSaveResult( result:Object, token:Object ):void
		{
			//dispatchEvent( new EntityManagerEvent( EntityManagerEvent.ENTITIES_SAVED) );
			busy = false;
		}
		
		
		protected function onFault( fault:FaultEvent, token:Object ):void
		{
			busy = false;
			//_em.rollback();
			throw new Error("[EntityManagerBase] save failed => " + fault.fault.faultString );
		}
		
		
		public function set busy( b:Boolean ):void
		{
			if( b != _busy) {
				
				_busy = b;
				
				if( _busy ) {
					CursorManager.setBusyCursor();
					loading = true;
				} else {
					CursorManager.removeBusyCursor();
					loading = false;
				}
				
				dispatchEvent( new Event("busyChange") );
			}
			
		}
		
		[Bindable(Event="busyChange")]
		public function get busy():Boolean
		{
			return _busy;
		}
	}
}