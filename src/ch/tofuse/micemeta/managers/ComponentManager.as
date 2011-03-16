package ch.tofuse.micemeta.managers
{
	import ch.tofuse.micemeta.views.ContentNavigator;
	import ch.tofuse.micemeta.events.ModuleManagerEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.ClassFactory;

	public class ComponentManager extends EventDispatcher
	{
		
		private var _dispatcher:IEventDispatcher;
		private var _components:Vector.<IContent>;
		private var _componentNavigator:ContentNavigator;
		
		private var _componentFactory:ClassFactory;
		
		public function ComponentManager() 
		{
			
		}
		
		public function set dispatcher( d:IEventDispatcher ):void
		{
			_dispatcher = d;
		}
		
		public function set components( c:Vector.<IContent> ):void
		{
			_components = c;
			dispatchEvent( new Event("componentsChange") );
		}
		
		[Bindable(Event="componentsChange")]
		public function get components():Vector.<IContent>
		{
			return _components;
		}
		
		
		public function addComponentInstanceToNavigator( m:IContent ):void
		{
			_componentFactory = new ClassFactory( Object(m).constructor );
			var componentInstance:IContent = _componentFactory.newInstance();
			_componentNavigator.addContent( componentInstance );
			
		}

		[Bindable(Event="componentNavigatorChange")]
		public function get componentNavigator():ContentNavigator
		{
			return _componentNavigator;
		}

		public function set componentNavigator( value:ContentNavigator ):void
		{
			_componentNavigator = value;
			dispatchEvent( new Event("componentNavigatorChange") );
		}
		
		
		
		
	}
}