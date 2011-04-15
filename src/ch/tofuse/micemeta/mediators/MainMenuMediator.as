package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.ContentEvent;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.views.menus.main.MainMenuView;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.states.OverrideBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMenuMediator extends Mediator
	{
		
		[Inject]
		public var view:MainMenuView;
		
		[Inject(name="ContentModel")]
		public var model:ContentModel;
		
		override public function onRegister():void
		{
			view.modules = model.modules;
			view.components = model.components;
			view.content = model.content;
			
			addViewListener( ContentEvent.ADD_CONTENT, addContent );
			
		}
		
		protected function addContent( event:ContentEvent ):void
		{
			dispatch( event );
		}
		
	}
}