package ch.tofuse.micemeta.views.modules.nestcheck
{
	import ch.tofuse.micemeta.entities.NestCheck;
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	import ch.tofuse.micemeta.formatters.GeneralDateFormatter;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	import ch.tofuse.micemeta.vo.MenuOptionVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	
	import spark.events.IndexChangeEvent;
	
	public class NestcheckMainContainer extends ModuleContainerBase
	{
		
		private var _view:NestcheckView;
		private var _options:Array; 
		private var _generalDateFormatter:GeneralDateFormatter;
		
		public function NestcheckMainContainer()
		{
			super();
			
			_generalDateFormatter = new GeneralDateFormatter();
			
			label = "Nestchecks";
			_options = [ new MenuOptionVO( 'Add', add ) ];
			menuOptionsData = new ArrayCollection( _options );
			
			_view = new NestcheckView();
			
		}
		
		override protected function build( event:FlexEvent ):void
		{
			super.build( event );
			
			menuEntriesList.labelFunction = nestcheckLabelFunction;
			
			repository = em.getRepository( NestCheck );
			repository.loadAll();
			menuEntriesData = em.getRepository( NestCheck ).entities;
		}
		
		override protected function entriesListChangeHandler( event:ItemClickEvent ):void
		{
			view = _view;
			_view.currentState = "edit";
			_view.nestcheck = NestCheck( event.item );
		}
		
		override protected function optionsListChangeHandler( event:ItemClickEvent ):void
		{
			view = _view;
			
			var menuOption:MenuOptionVO = MenuOptionVO( event.item );
			menuOption.method.call();
			
		}
		
		private function add():void
		{
			_view.currentState = "add";
			disableControls();
		}
		
		private function nestcheckLabelFunction( nc:NestCheck ):String
		{
			return _generalDateFormatter.format( nc.checkdate );
		}
		
	}
}