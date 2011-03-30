package ch.tofuse.micemeta.models
{
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.views.components.mouse.MiceMainContainer;
	import ch.tofuse.micemeta.views.modules.genetic.GeneticsMainContainer;
	import ch.tofuse.micemeta.views.modules.location.LocationMainContainer;
	import ch.tofuse.micemeta.views.modules.nestcheck.NestcheckMainContainer;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ContentModel extends Actor
	{
		private var _modules:Vector.<IContent>;
		private var _components:Vector.<IContent>;
		
		
		public function get modules():Vector.<IContent>
		{
			if( _modules == null ) {
				_modules = new Vector.<IContent>();
				_modules.push( new NestcheckMainContainer(), new GeneticsMainContainer()  );
			}
			
			return _modules;		
	
		}
		
		public function get components():Vector.<IContent>
		{
			if( _components == null ) {
				_components = new Vector.<IContent>();
				_components.push( new MiceMainContainer(), new LocationMainContainer() );
			}
			
			return _components;
		}
		
		public function get content():Vector.<IContent>
		{
			return modules.concat( components );
		}
		
	}
}