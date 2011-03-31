package ch.tofuse.micemeta.views.components
{
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.EntityEvent;
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	import org.davekeen.flextrine.orm.collections.EntityCollection;
	
	import spark.components.BorderContainer;
	import spark.components.SkinnableContainer;
	
	public class AbstractComponentView extends SkinnableContainer
	{
		
		[Bindable] public var entities:EntityCollection;
		
		private var _repository:IEntityRepository;
		private var _entityManager:EntityManager;
		
		protected var persistEntityEvent:EntityMediatorEvent;
		protected var removeEntityEvent:EntityMediatorEvent;
		protected var flushEvent:EntityManagerEvent;
		
		public function AbstractComponentView()
		{
			super();
			
			layoutDirection = "ltr";
			
			addEventListener( EntityEvent.PERSIST_ENTITY, addEntity );
			//addEventListener( EntityEvent.EDIT_ENTITY, editEntity );
			addEventListener( EntityEvent.REMOVE_ENTITY, removeEntity );
			
			removeEntityEvent = new EntityMediatorEvent( EntityMediatorEvent.ENTITY_REMOVE, {} );
			persistEntityEvent = new EntityMediatorEvent( EntityMediatorEvent.ENTITY_PERSIST, {} );
			
			flushEvent = new EntityManagerEvent( EntityManagerEvent.FLUSH );
		}
		
		public function get repository():IEntityRepository
		{
			return _repository;
		}
		
		public function set repository(value:IEntityRepository):void
		{
			_repository = value;
		}
		
		public function get entityManager():EntityManager
		{
			return _entityManager;
		}
		
		public function set entityManager(value:EntityManager):void
		{
			_entityManager = value;
		}
		
		protected function addEntity( e:EntityEvent ):void
		{
			trace("\t=> addEntity not implemented");
		}
		
		protected function editEntity( e:EntityEvent ):void
		{
			trace("\t=> editEntity not implemented");
		}
		
		protected function removeEntity( e:EntityEvent ):void
		{
			trace("\t=> removeEntity not implemented");
		}
		
		protected function onLoadFault(fault:Object, token:Object):void {
			throw new Error("An error occurred during load: " + fault);
		}
		
		protected function save():void
		{
			dispatchEvent( flushEvent ); 
		}
		
		protected function dispatchPersistEntity( e:* ):void
		{
			persistEntityEvent.entity = e;
			dispatchEvent( persistEntityEvent );
		}
		
		protected function dispatchRemoveEntity( e:* ):void
		{
			removeEntityEvent.entity = e;
			dispatchEvent( removeEntityEvent );
		}

	}
}