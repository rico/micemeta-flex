package ch.tofuse.micemeta.managers
{
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityManagerInstanceEvent;
	
	import com.asfusion.mate.utils.debug.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	import mx.managers.CursorManager;
	import mx.managers.DragManager;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	
	import org.davekeen.collections.IndexedArrayCollection;
	import org.davekeen.flextrine.orm.Configuration;
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	import org.davekeen.flextrine.orm.collections.EntityCollection;
	import org.davekeen.flextrine.orm.metadata.MetaTags;
	import org.davekeen.flextrine.util.ClassUtil;
	import org.davekeen.flextrine.util.EntityUtil;
	
	public class EntityManagerBase extends EventDispatcher
	{
		
		protected var _idField:String;
		protected var _entityManagerInstance:EntityManagerInstance;
		protected var _configuration:Configuration;
		protected var _class:Class;
		protected var _entititesLoaded:Boolean = false;
		protected var _busy:Boolean;
		protected var _loading:Boolean;
		protected var _entitiesLoading:Boolean;
		protected var _cursor:IViewCursor;
		protected var _entities:EntityCollection;
		protected var _sort:Sort;
		protected var _responder:AsyncToken;
		
		
		private var _dispatcher:IEventDispatcher;
		private var _repository:IEntityRepository;
		private var _entityTimeToLive:Number = 60000;
		private var _entityTimeToLiveSet:Boolean;
		
		public function EntityManagerBase( cls:Class )
		{
			_class = cls;
			_idField = EntityUtil.getAttributesWithTag( new _class(), MetaTags.ID ); 
			
			dispatchEvent( new EntityManagerInstanceEvent( EntityManagerInstanceEvent.INIT_ENTITY_MANAGER_INSTANCE ) );	
		
			
			// Get a logger for this class
			//Log.addTarget( new TraceTarget() );
			//_logger = Log.getLogger(ClassUtil.getQualifiedClassNameAsString(this));
			
		}
		
		public function set entityManagerInstance( emi:EntityManagerInstance ):void
		{
			_entityManagerInstance = emi;
			dispatchEvent( new Event("entityManagerInstanceChange") );
		}
		
		[Bindable(Event="entityManagerInstanceChange")]
		public function get entityManager():EntityManager
		{
			return _entityManagerInstance.entityManager;
			dg:DragManager
		}
		
		public function set dispatcher( d:IEventDispatcher ):void
		{
			_dispatcher = d;
		}
		
		public function get repository():IEntityRepository
		{
			
			if( _repository == null ) {
				_repository = entityManager.getRepository( _class, _entityTimeToLive );
				_entityTimeToLiveSet = true;
			}
			
			return _repository;
		}
		
		public function set entityTimeToLive( ttl:Number ):void
		{
			if( !_entityTimeToLiveSet ) {
				_entityTimeToLive = ttl;
				_entityTimeToLiveSet = true;
			}
		}
		
		public function loadAll( showBusy:Boolean = true ):void
		{
			if( !_entitiesLoading && !_entititesLoaded ) {
				repository.loadAll().addResponder( new AsyncResponder(onEntitiesLoadResult, onLoadFault) );
				_entitiesLoading = true;
				loading = true;
				busy = showBusy;
			} else if ( _entititesLoaded ) {
				dispatchEvent( new EntityManagerEvent( EntityManagerEvent.ENTITIES_LOADED) );
			}
		}
		
		[Bindable(Event="entitiesChanged")]
		public function get entities():EntityCollection
		{
			
			if( _entities == null ) { 
				_entities = repository.entities;
				_sort = new Sort();
				_sort.fields = [ new SortField( _idField, true, false )];
				_entities.sort = _sort;
				_entities.refresh();
			}
			
			if( !_entititesLoaded && !_entitiesLoading ) {
				loadAll();
			}
			
			return _entities;
		}
		
		public function get cls():Class
		{
			return _class;
		}
		
		public function save():void
		{
			entityManager.flush().addResponder( new AsyncResponder(onSaveResult, onFault) );
			_entititesLoaded = false;
			//loadAll( true );
			busy = true;
			
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
		
		public function set loading( dl:Boolean ):void
		{
			if( dl != _loading ) {
				_loading = dl;
				dispatchEvent( new Event("loadingChange") );
			}
		}
		
		[Bindable(Event="loadingChange")]
		public function get loading():Boolean
		{
			return _loading;
		}
		
		[Bindable(Event="busyChange")]
		public function get busy():Boolean
		{
			return _busy;
		}
		
		public function get cursor():IViewCursor
		{
			if( !_cursor ) {
				_cursor = entities.createCursor();
			}
			
			return _cursor;
		}
		
		public function sortEntitiesByField( field:String, numeric:Boolean ):void 
		{
			var sf:SortField = new SortField( field, true, false, numeric );
			_sort.fields = [ sf ];
			_entities.refresh();
		}
		
		public function addEntity( e:* , save:Boolean = false ):void
		{
			entityManager.persist( e );
			
			
			if( save ) {
				this.save();
			}
		}
		
		public function deleteEntity( e:*, save:Boolean = false ):void
		{
			entityManager.remove( e );
			_entities.refresh();
			
			if( save ) {
				this.save();
			}
		}
		
		/* EVENT HANDLERS */
		
		protected function onEntitiesLoadResult( result:Object, token:Object ):void
		{
			_entitiesLoading = false;
			_entititesLoaded = true;
			dispatchEvent( new Event("entitiesChanged") );
			dispatchEvent( new EntityManagerEvent( EntityManagerEvent.ENTITIES_LOADED) );
			busy = false;
			
		}
		
		protected function onSaveResult( result:Object, token:Object ):void
		{
			dispatchEvent( new EntityManagerEvent( EntityManagerEvent.ENTITIES_SAVED) );
			busy = false;
		}
		
		
		protected function onFault( fault:FaultEvent, token:Object ):void
		{
			busy = false;
			//_em.rollback();
			throw new Error("[EntityManagerBase] save failed => " + fault.fault.faultString );
		}
		
		protected function onLoadFault( result:Object, token:Object ):void
		{
			_entitiesLoading = false;
			busy = false;
			throw new Error("[EntityManagerBase] load failed => " + token.toString() ); 			
		}
		
		protected function onDqlSelectFault( fault:Object, token:Object ):void {
			busy = false;
			throw new Error("[EntityManagerBase] DQL select error => " + fault);
		}
		
	}
}