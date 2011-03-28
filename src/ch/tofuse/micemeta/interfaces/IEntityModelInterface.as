package ch.tofuse.micemeta.interfaces
{
	import mx.collections.IViewCursor;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;

	public interface IEntityModelInterface
	{
		function get entityManager():EntityManager;
		function get repository():IEntityRepository;
		function set busy( b:Boolean ):void;
		function get busy():Boolean;
		function get cursor():IViewCursor;
		
		function loadAll():void;
		function flush():void;
		function sortEntitiesByField( field:String, numeric:Boolean):void
		function persist( entity:*, flush:Boolean = false ):void;
		function remove( entity:*, flush:Boolean = false ):void;
		
	}
}