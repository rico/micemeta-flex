package ch.tofuse.micemeta.interfaces
{
	import ch.tofuse.micemeta.events.EntityModelEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IViewCursor;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;

	public interface IEntityModelInterface
	{
		function get entityManager():EntityManager;
		function get repository():IEntityRepository;
		function get cursor():IViewCursor;
		
		function loadAll( eventToDispatchWhenLoaded:EntityModelEvent ):void;
		function flush():void;
		function sortEntitiesByField( field:String, numeric:Boolean):void
		function persist( entity:*, flush:Boolean = false ):void;
		function remove( entity:*, flush:Boolean = false ):void;
		function get eventDispatcher():IEventDispatcher;
		
	}
}