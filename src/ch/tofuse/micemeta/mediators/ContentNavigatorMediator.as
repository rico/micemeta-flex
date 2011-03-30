package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.config.SettingsConfig;
	import ch.tofuse.micemeta.events.ContentEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.views.ContentNavigatorView;
	
	import flash.net.SharedObject;
	
	import mx.core.ClassFactory;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ContentNavigatorMediator extends Mediator
	{
		[Inject]
		public var view:ContentNavigatorView;
		
		[Inject]
		public var model:ContentModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener( eventDispatcher, ContentEvent.ADD_CONTENT, addContent );
			addStartupContent();
		}
		
		protected function addContent(event:ContentEvent):void
		{
			var contentFactory:ClassFactory = new ClassFactory( Object( event.content ).constructor );
			var contentInstance:IContent = contentFactory.newInstance();
			view.addContent( contentInstance );
		}
		
		protected function addStartupContent():void
		{
				
			var settings:SharedObject = SharedObject.getLocal( SettingsConfig.SHARED_OBEJECT_NAME );
			//settings.clear();
			if( settings.data[ SettingsConfig.STARTUP_CONTENT_NAME ] != null ) {
				var startupContents:Array = settings.data[ SettingsConfig.STARTUP_CONTENT_NAME ];
				for each ( var startupContentLabel:String in startupContents ) {
					for each( var content:IContent in model.content ) {
						if( content.label == startupContentLabel) {
							addContent( new ContentEvent( ContentEvent.ADD_CONTENT, content ) );
							break;
						}
					}
				}
				
				// bug workaround see: http://bugs.adobe.com/jira/browse/SDK-15974
				view.setInitialIndex();
			}
			
			
			
		}
		
	}
}