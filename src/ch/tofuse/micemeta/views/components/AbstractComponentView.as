package ch.tofuse.micemeta.views.components
{
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.EntityEvent;
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	import org.davekeen.flextrine.orm.collections.EntityCollection;
	
	import spark.components.BorderContainer;
	import spark.components.SkinnableContainer;
	
	public class AbstractComponentView extends SkinnableContainer
	{
		
		//[Bi]protected var em:EntityManager;
		[Bindable] public var repository:IEntityRepository;
		[Bindable] public var entities:EntityCollection;
		
		public function AbstractComponentView()
		{
			super();
			
			layoutDirection = "ltr";
			
			addEventListener( EntityEvent.PERSIST_ENTITY, addEntity );
			addEventListener( EntityEvent.EDIT_ENTITY, editEntity );
			addEventListener( EntityEvent.REMOVE_ENTITY, removeEntity );
			
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
		
	}
}