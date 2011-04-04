package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.config.SettingsConfig;
	import ch.tofuse.micemeta.events.ContentEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.views.ContentNavigatorView;
	
	import flash.net.SharedObject;
	
	import mx.controls.Alert;
	import mx.core.ClassFactory;
	import mx.events.CloseEvent;
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.robotlegs.mvcs.Mediator;
	
	public class ContentNavigatorMediator extends Mediator
	{
		[Inject]
		public var view:ContentNavigatorView;
		
		[Inject]
		public var model:ContentModel;
		
		
		[Embed(source="ch/tofuse/micemeta/assets/img/attention.png")]
		[Bindable]
		public var attentionIcon:Class;
		
		private var _em:EntityManager;
		private var _contentToRemoveEvent:ContentEvent;
		
		public function ContentNavigatorMediator()
		{
			_em = EntityManager.getInstance();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener( eventDispatcher, ContentEvent.ADD_CONTENT, addContent );
			addViewListener( ContentEvent.REMOVE_CONTENT, removeContent, ContentEvent );
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
			for each ( var startupContentLabel:String in SettingsConfig.instance.startupContent ) {
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
		
		protected function removeContent( e:ContentEvent ):void
		{
			_contentToRemoveEvent = e;
			_em.flush().addResponder( new AsyncResponder(onFlushSuccess, onFlushError) );	
			
			view.removeContent( _contentToRemoveEvent.content );
			
		}	
		
		/*private function showChangesConfirmationAlert():void
		{
			Alert.show( "Do you want to save the changes you made to the data?", 
				"Save Changes",
				Alert.NO | Alert.YES, 
				null, 
				changesConfirmationCloseHandler, 
				attentionIcon, 
				Alert.YES); 
		}
		
		private function changesConfirmationCloseHandler( e:CloseEvent ):void
		{
			if ( e.detail == Alert.YES) {
				_em.flush();			 
			} else {
				_em.rollback();
			}
			
			dispatch( _contentToRemoveEvent );
			
		}*/
		
		private function onFlushSuccess( result:Object, token:Object ):void
		{
			view.resetPendingChanges();
			view.removeContent( _contentToRemoveEvent.content );
			
		}
		
		
		protected function onFlushError( fault:FaultEvent, token:Object ):void
		{
			throw new Error("[ContentNavigatorMediator] flush failed => " + fault.fault.faultString );
		}
		
	}
}