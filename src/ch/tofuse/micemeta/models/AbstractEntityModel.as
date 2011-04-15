package ch.tofuse.micemeta.models
{
	import ch.tofuse.micemeta.events.EntityModelEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.events.CollectionEvent;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	import org.davekeen.flextrine.orm.collections.EntityCollection;
	import org.davekeen.flextrine.orm.metadata.MetaTags;
	import org.davekeen.flextrine.util.EntityUtil;
	import org.robotlegs.mvcs.Actor;
	
	
	public class AbstractEntityModel extends Actor implements IEntityModelInterface
	{
		
		protected var _idField:String;
		protected var _class:Class;
		protected var _entititesLoaded:Boolean;
		protected var _busy:Boolean;
		protected var _loading:Boolean;
		protected var _entitiesLoading:Boolean;
		protected var _cursor:IViewCursor;
		protected var _entities:EntityCollection;
		protected var _sort:Sort;
		protected var _responder:AsyncToken;
		protected var _eventToDispatchWhenLoaded:EntityModelEvent;
		
		private var _em:EntityManager;
		private var _dispatcher:IEventDispatcher;
		private var _repository:IEntityRepository;
		
		public function AbstractEntityModel( cls:Class ):void
		{
			_class = cls;
			_idField = EntityUtil.getAttributesWithTag( new _class(), MetaTags.ID ); 
		}
		
		public function get entityManager():EntityManager
		{
			if( !_em ) {
				_em = EntityManager.getInstance();
			}
			
			return _em;
		}
		
		public function get repository():IEntityRepository
		{
			
			if( !_repository  ) {
				_repository = entityManager.getRepository( _class );
				loadAll( new EntityModelEvent( EntityModelEvent.ENTITIES_LOADED, this ) );
			}
			
			return _repository;
		}
		
		public function loadAll( eventToDispatchWhenLoaded:EntityModelEvent ):void
		{
			if( !_entitiesLoading && !_entititesLoaded ) {
				_eventToDispatchWhenLoaded = eventToDispatchWhenLoaded;
				_entitiesLoading = true;
				repository.loadAll().addResponder( new AsyncResponder(onEntitiesLoadResult, onLoadFault) );
			} else if( !_loading && _entititesLoaded ) {
				if( _eventToDispatchWhenLoaded ) {
					dispatch( _eventToDispatchWhenLoaded );
				}
			}
		}
		
		public function get cls():Class
		{
			return _class;
		}
		
		public function flush():void
		{
			entityManager.flush().addResponder( new AsyncResponder(onSaveResult, onFault) );
			_entititesLoaded = false;
			
		}
		
		public function get cursor():IViewCursor
		{
			if( !_cursor ) {
				_cursor = repository.entities.createCursor();
			}
			
			return _cursor;
		}
		
		public function sortEntitiesByField( field:String, numeric:Boolean ):void 
		{
			var sf:SortField = new SortField( field, true, false, numeric );
			
			if( !_sort ) {
				_sort = new Sort();
				_entities.sort = _sort;
			}
			
			_sort.fields = [ sf ];
			_entities.refresh();
		}
		
		public function persist( e:* , f:Boolean = false ):void
		{
			entityManager.persist( e );
			refreshSort();
			
			if( f ) {
				flush();
			}
		}
		
		public function remove( e:*, f:Boolean = false ):void
		{
			entityManager.remove( e );
			refreshSort();
			
			if( f ) {
				flush();
			}
		}
		
		private function refreshSort():void
		{
			_sort = new Sort();
			_sort.fields = [ new SortField( _idField) ];
			repository.entities.sort = _sort;
			repository.entities.refresh();
		}
		
		/* EVENT HANDLERS */
		
		protected function onEntitiesLoadResult( result:Object, token:Object ):void
		{
			_entitiesLoading = false;
			_entititesLoaded = true;
			refreshSort();
			
			if( _eventToDispatchWhenLoaded ) {
				dispatch( _eventToDispatchWhenLoaded );
			}
			
		}
		
		protected function onSaveResult( result:Object, token:Object ):void
		{
			//dispatchEvent( new EntityManagerEvent( EntityManagerEvent.ENTITIES_SAVED) );
		}
		
		protected function onFault( fault:FaultEvent, token:Object ):void
		{
			throw new Error("[EntityManagerBase] save failed => " + fault.fault.faultString );
		}
		
		protected function onLoadFault( result:Object, token:Object ):void
		{
			_entitiesLoading = false;
			throw new Error( "[EntityManagerBase] load failed => " + token.toString() ); 			
		}
		
		protected function onDqlSelectFault( fault:Object, token:Object ):void {
			throw new Error( "[EntityManagerBase] DQL select error => " + fault );
		}

	}
}