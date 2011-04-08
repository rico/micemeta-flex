package ch.tofuse.micemeta.views.components
{
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.EntityEvent;
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	import ch.tofuse.micemeta.events.PendingChangesEvent;
	import ch.tofuse.micemeta.skins.components.AbstractComponentViewSkin;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.states.State;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	import org.davekeen.flextrine.orm.collections.EntityCollection;
	
	import spark.components.BorderContainer;
	import spark.components.SkinnableContainer;
	
	public class AbstractComponentView extends SkinnableContainer
	{
		
		[Bindable] public var entities:EntityCollection;
		
		[Bindable] protected var _mode:String;
		
		private var _repository:IEntityRepository;
		private var _entityManager:EntityManager;
		
		protected var persistEntityEvent:EntityMediatorEvent;
		protected var removeEntityEvent:EntityMediatorEvent;
		protected var flushEvent:EntityManagerEvent;
		
		public function AbstractComponentView()
		{
			super();
			
			layoutDirection = "ltr";
			setStyle('skinClass', AbstractComponentViewSkin);
			
			removeEntityEvent = new EntityMediatorEvent( EntityMediatorEvent.ENTITY_REMOVE, {} );
			persistEntityEvent = new EntityMediatorEvent( EntityMediatorEvent.ENTITY_PERSIST, {} );
			
			flushEvent = new EntityManagerEvent( EntityManagerEvent.FLUSH );
		}
			
		
		[Bindable(Event="repositoryChanged")]
		public function get repository():IEntityRepository
		{
			return _repository;
		}
		
		public function set repository(value:IEntityRepository):void
		{
			_repository = value;
			dispatchEvent( new Event("repositoryChanged") );
		}
		
		public function get entityManager():EntityManager
		{
			return _entityManager;
		}
		
		public function set entityManager(value:EntityManager):void
		{
			_entityManager = value;
		}
		
		[Bindable(Event="modeChanged")]
		public function get mode():String
		{
			return _mode;
		}
		
		[Inspectable(category="General",type="String", defaultValue="view",enumeration="view, edit, add")]
		public function set mode(value:String):void
		{
			_mode = value;
			currentState = _mode;
			dispatchEvent( new Event("modeChanged") );
		}
				
		protected function onLoadFault(fault:Object, token:Object):void {
			throw new Error("An error occurred during load: " + fault);
		}
		
		protected function save():void
		{
			dispatchEvent( flushEvent ); 
			dispatchEvent( new PendingChangesEvent( PendingChangesEvent.PENDING_CHANGES, false) );
		}
		
		protected function dispatchPersistEntity( e:* ):void
		{
			persistEntityEvent.entity = e;
			dispatchEvent( persistEntityEvent );
			dispatchEvent( new PendingChangesEvent( PendingChangesEvent.PENDING_CHANGES, true) );
		}
		
		protected function dispatchRemoveEntity( e:* ):void
		{
			removeEntityEvent.entity = e;
			dispatchEvent( removeEntityEvent );
			dispatchEvent( new PendingChangesEvent( PendingChangesEvent.PENDING_CHANGES, true) );
		}
		
	}
}