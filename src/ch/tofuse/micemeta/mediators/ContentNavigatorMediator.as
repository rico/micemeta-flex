package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.MainMenuEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.views.ContentNavigator;
	
	import mx.core.ClassFactory;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ContentNavigatorMediator extends Mediator
	{
		[Inject]
		public var view:ContentNavigator;
		
		override public function onRegister():void
		{
			eventMap.mapListener( eventDispatcher, MainMenuEvent.ADD_CONTENT, addContent );			
		}
		
		protected function addContent(event:MainMenuEvent):void
		{
			var contentFactory:ClassFactory = new ClassFactory( Object( event.content ).constructor );
			var contentInstance:IContent = contentFactory.newInstance();
			view.addContent( contentInstance );
		}
			
	}
}