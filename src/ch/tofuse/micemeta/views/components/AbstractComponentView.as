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
		
		[Embed(source="ch/tofuse/micemeta/assets/img/attention.png")]
		[Bindable]
		public var attentionIcon:Class;
		
		[Bindable] public var entities:EntityCollection;
		
		public var repository:IEntityRepository;
		public var entityManager:EntityManager;
		
		protected var persistEntityEvent:EntityMediatorEvent;
		protected var removeEntityEvent:EntityMediatorEvent;
		protected var flushEvent:EntityManagerEvent;
		
		public function AbstractComponentView()
		{
			super();
			
			layoutDirection = "ltr";
			
			addEventListener( EntityEvent.PERSIST_ENTITY, addEntity );
			addEventListener( EntityEvent.EDIT_ENTITY, editEntity );
			addEventListener( EntityEvent.REMOVE_ENTITY, removeEntity );
			
			addEventListener( Event.REMOVED, dispatchFocusOutEvent );
			
			removeEntityEvent = new EntityMediatorEvent( EntityMediatorEvent.ENTITY_REMOVE, {} );
			persistEntityEvent = new EntityMediatorEvent( EntityMediatorEvent.ENTITY_PERSIST, {} );
			
			flushEvent = new EntityManagerEvent( EntityManagerEvent.FLUSH );
		}
		
		
		protected function addEntity( e:EntityEvent ):void
		{
			throw new Error("\t=> override this method");
		}
		
		protected function editEntity( e:EntityEvent ):void
		{
			throw new Error("\t=> override this method");
		}
		
		protected function removeEntity( e:EntityEvent ):void
		{
			throw new Error("\t=> override this method");
		}
		
		protected function onLoadFault(fault:Object, token:Object):void {
			throw new Error("An error occurred during load: " + fault);
		}
		
		protected function done():void
		{
			dispatchEvent( new ComponentEvent( ComponentEvent.DONE ) ); 
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
		
		/* view focus out changes confirmation */
		protected function dispatchFocusOutEvent( e:Event ):void
		{
			dispatchEvent( new EntityManagerEvent( EntityManagerEvent.CHECK_PENDING_CHANGES ) );
		}
		
		public function showChangesConfirmationAlert():void
		{
			Alert.show( "Do you want to save the changes you made to the data?", 
				"Save Changes",
				Alert.NO | Alert.YES, 
				null, 
				changesConfirmationCloseHandler, 
				attentionIcon, 
				Alert.YES); 
		}
		
		public function changesConfirmationCloseHandler( e:CloseEvent ):void
		{
			if ( e.detail == Alert.YES) {
				dispatchEvent( new EntityManagerEvent( EntityManagerEvent.FLUSH ) );			 
			} else {
				dispatchEvent( new EntityManagerEvent( EntityManagerEvent.ROLLBACK ) );
			}
			
		}
		
	}
}