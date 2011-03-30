package ch.tofuse.micemeta.managers
{
	import ch.tofuse.micemeta.views.ContentNavigatorView;
	import ch.tofuse.micemeta.events.ModuleManagerEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.ClassFactory;

	public class ModuleManager extends EventDispatcher
	{
		
		private var _dispatcher:IEventDispatcher;
		private var _modules:Vector.<IContent>;
		private var _moduleNavigator:ContentNavigatorView;
		
		private var _moduleFactory:ClassFactory;
		
		public function ModuleManager() 
		{
			
		}
		
		public function set dispatcher( d:IEventDispatcher ):void
		{
			_dispatcher = d;
		}
		
		public function set modules( m:Vector.<IContent> ):void
		{
			_modules = m;
			dispatchEvent( new Event("modulesChange") );
		}
		
		[Bindable(Event="modulesChange")]
		public function get modules():Vector.<IContent>
		{
			return _modules;
		}
		
		
		public function addModuleInstanceToNavigator( m:IContent ):void
		{
			_moduleFactory = new ClassFactory( Object(m).constructor );
			var moduleInstance:IContent = _moduleFactory.newInstance();
			_moduleNavigator.addContent( moduleInstance );
			
		}
		

		[Bindable(Event="moduleNavigatorChange")]
		public function get moduleNavigator():ContentNavigatorView
		{
			return _moduleNavigator;
		}

		public function set moduleNavigator(value:ContentNavigatorView):void
		{
			_moduleNavigator = value;
			dispatchEvent( new Event("moduleNavigatorChange") );
		}
		
		
		
		
	}
}