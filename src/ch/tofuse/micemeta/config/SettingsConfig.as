package ch.tofuse.micemeta.config
{
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.views.modules.nestcheck.NestcheckModuleView;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	import mx.controls.Alert;
	
	public class SettingsConfig extends EventDispatcher
	{
		
		public static const SHARED_OBEJECT_NAME:String = "micemeta";
		public static const STARTUP_CONTENT_NAME:String = "startupContent";
		public static const DEFAULT_STARTUP_CONTENT:IContent = new NestcheckModuleView();
		
		private static var _instance:SettingsConfig;
		private var _so:SharedObject;
		
		public function SettingsConfig()
		{
			if ( _instance )
			{
				throw new Error("Singleton can only be accessed through Singleton.instance");
			}	
			
			_instance = this;
			_so = SharedObject.getLocal( SHARED_OBEJECT_NAME );
			
		}
		
		public static function get instance():SettingsConfig
		{
			if ( !_instance ) {
				_instance = new SettingsConfig(); 
			}
			
			return _instance; 
		}
		
		[Bindable(Event="startupContentChanged")]
		public function get startupContent():Array
		{
			if ( !_so.data.hasOwnProperty( STARTUP_CONTENT_NAME ) || (_so.data[ STARTUP_CONTENT_NAME ] as Array).length == 0 ) {
				_so.data[ STARTUP_CONTENT_NAME ] = [ DEFAULT_STARTUP_CONTENT.label ];
				flush();
			} 
			
			return _so.data[ STARTUP_CONTENT_NAME ];
		}
		
		public function set startupContent( sc:Array ):void
		{
			_so.data[ STARTUP_CONTENT_NAME ] = sc;
			flush();
			//clear();
			dispatchEvent( new Event("startupContentChanged") );
		}
		
		private function clear():void
		{
			try {
				_so.clear();
			} catch( err:Error ) {
				Alert.show("Clear settings failed: " + err.message, "Save failed");
			}
		}
		
		private function flush():void
		{
			try {
				_so.flush()
			} catch( err:Error ) {
				Alert.show("Save settings failed: " + err.message, "Save failed");
			}
		}
	}
}