package ch.tofuse.micemeta.context
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.mediators.BoxMediator;
	import ch.tofuse.micemeta.mediators.ContentNavigatorMediator;
	import ch.tofuse.micemeta.mediators.MainMenuMediator;
	import ch.tofuse.micemeta.mediators.OtherLocationMediator;
	import ch.tofuse.micemeta.models.AbstractEntityModel;
	import ch.tofuse.micemeta.models.BoxModel;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.models.OtherLocationModel;
	import ch.tofuse.micemeta.views.ContentNavigator;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.box.BoxView;
	import ch.tofuse.micemeta.views.components.otherlocation.OtherLocationView;
	import ch.tofuse.micemeta.views.menus.main.MainMenu;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class ApplicationContext extends Context
	{
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			injector.mapSingleton( ContentModel );
			injector.mapSingletonOf( IEntityModelInterface, OtherLocationModel,'OtherLocationModel' );
			injector.mapSingletonOf( IEntityModelInterface, BoxModel, 'BoxModel' );
			
			mediatorMap.mapView( MainMenu, MainMenuMediator );
			mediatorMap.mapView( ContentNavigator, ContentNavigatorMediator );
			
			mediatorMap.mapView( OtherLocationView, OtherLocationMediator, AbstractComponentView );
			mediatorMap.mapView( BoxView, BoxMediator, AbstractComponentView );
			
		}
	}
}