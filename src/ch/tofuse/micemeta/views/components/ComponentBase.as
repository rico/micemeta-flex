package ch.tofuse.micemeta.views.components
{
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	
	import flash.events.Event;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	
	import spark.components.BorderContainer;
	
	public class ComponentBase extends BorderContainer
	{
		
		protected var em:EntityManager;
		[Bindable] protected var repository:IEntityRepository;
		
		public function ComponentBase()
		{
			super();
			
			layoutDirection = "ltr";
			percentWidth = 100;
			
			em = EntityManager.getInstance();
			
			addEventListener( "addItem", addItem );
			addEventListener( "editItem", editItem );
			addEventListener( "deleteItem", deleteItem );
			
		}
		
		protected function addItem( event:Event ):void
		{
			event.stopImmediatePropagation();
		}
		
		protected function editItem( event:Event ):void
		{
			event.stopImmediatePropagation();
		}
		
		protected function deleteItem( event:Event ):void
		{
			event.stopImmediatePropagation();
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