package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.MainMenuEvent;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.views.menus.main.MainMenu;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	
	import mx.states.OverrideBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMenuMediator extends Mediator
	{
		
		[Inject]
		public var view:MainMenu;
		
		[Inject]
		public var contentModel:ContentModel;
		
		override public function onRegister():void
		{
			view.modules = contentModel.modules;
			view.components = contentModel.components;
			
			addViewListener( MainMenuEvent.ADD_CONTENT, addContent );
		}
		
		protected function addContent( event:MainMenuEvent ):void
		{
			dispatch( event );
		}
		
	}
}