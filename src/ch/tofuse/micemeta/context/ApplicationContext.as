package ch.tofuse.micemeta.context
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.mediators.BoxMediator;
	import ch.tofuse.micemeta.mediators.ContentNavigatorMediator;
	import ch.tofuse.micemeta.mediators.LitterMediator;
	import ch.tofuse.micemeta.mediators.MainMenuMediator;
	import ch.tofuse.micemeta.mediators.NestcheckLitterViewMediator;
	import ch.tofuse.micemeta.mediators.NestcheckLocationCheckMediator;
	import ch.tofuse.micemeta.mediators.NestcheckModuleMediator;
	import ch.tofuse.micemeta.mediators.NestcheckOverviewMediator;
	import ch.tofuse.micemeta.mediators.NestcheckViewMediator;
	import ch.tofuse.micemeta.mediators.OtherLocationMediator;
	import ch.tofuse.micemeta.models.BoxCheckModel;
	import ch.tofuse.micemeta.models.BoxModel;
	import ch.tofuse.micemeta.models.ContentModel;
	import ch.tofuse.micemeta.models.LitterModel;
	import ch.tofuse.micemeta.models.MouseModel;
	import ch.tofuse.micemeta.models.NestcheckModel;
	import ch.tofuse.micemeta.models.OtherLocationCheckModel;
	import ch.tofuse.micemeta.models.OtherLocationModel;
	import ch.tofuse.micemeta.views.ContentNavigatorView;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.box.BoxView;
	import ch.tofuse.micemeta.views.components.litter.LitterView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckLitterView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckLocationCheckView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckOverview;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	import ch.tofuse.micemeta.views.components.otherlocation.OtherLocationView;
	import ch.tofuse.micemeta.views.menus.main.MainMenuView;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	import ch.tofuse.micemeta.views.modules.nestcheck.NestcheckModuleView;
	
	import org.robotlegs.mvcs.Context;
	
	public class ApplicationContext extends Context
	{
		
		override public function startup():void
		{
			// MODELS
			injector.mapSingleton( ContentModel, "ContentModel" );
			injector.mapSingletonOf( IEntityModelInterface, OtherLocationModel,'OtherLocationModel' );
			injector.mapSingletonOf( IEntityModelInterface, BoxModel, 'BoxModel' );
			injector.mapSingletonOf( IEntityModelInterface, NestcheckModel, 'NestcheckModel' );
			injector.mapSingletonOf( IEntityModelInterface, BoxCheckModel, 'BoxCheckEntityModel' );
			injector.mapSingletonOf( IEntityModelInterface, OtherLocationCheckModel, 'OtherLocationCheckModel' );
			injector.mapSingletonOf( IEntityModelInterface, LitterModel, 'LitterModel' );
			injector.mapSingletonOf( IEntityModelInterface, MouseModel, 'MouseModel' );
			
			// MEDIATORS
			mediatorMap.mapView( MainMenuView, MainMenuMediator );
			mediatorMap.mapView( ContentNavigatorView, ContentNavigatorMediator );
			
			// modules
			mediatorMap.mapView( NestcheckModuleView, NestcheckModuleMediator, AbstractModuleView );
			
			// components
			mediatorMap.mapView( OtherLocationView, OtherLocationMediator, AbstractComponentView );
			mediatorMap.mapView( BoxView, BoxMediator, AbstractComponentView );
			mediatorMap.mapView( LitterView, LitterMediator, AbstractComponentView );
			mediatorMap.mapView( NestcheckView, NestcheckViewMediator, AbstractComponentView );
			mediatorMap.mapView( NestcheckOverview, NestcheckOverviewMediator, AbstractComponentView );
			mediatorMap.mapView( NestcheckLocationCheckView, NestcheckLocationCheckMediator, AbstractComponentView );
			mediatorMap.mapView( NestcheckLitterView, NestcheckLitterViewMediator, AbstractComponentView );
			
		}
	}
}