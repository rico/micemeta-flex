package ch.tofuse.micemeta.views.modules.nestcheck
{
	import ch.tofuse.micemeta.entities.NestCheck;
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	import ch.tofuse.micemeta.formatters.GeneralDateFormatter;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	import ch.tofuse.micemeta.vo.MenuOptionVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.utils.ObjectProxy;
	
	import org.davekeen.flextrine.orm.EntityProxy;
	import org.davekeen.flextrine.orm.collections.EntityCollection;
	
	import spark.events.IndexChangeEvent;
	
	public class NestcheckModuleView extends AbstractModuleView
	{
		
		private var _view:NestcheckView;
		private var _options:Array; 
		private var _generalDateFormatter:GeneralDateFormatter;
		
		private var _nestcheck:NestCheck;
		
		private var _addOption:MenuOptionVO;
		private var _editOption:MenuOptionVO;
		
		
		public function NestcheckModuleView()
		{
			super();
			
			_generalDateFormatter = new GeneralDateFormatter();
			
			label = "Nestchecks";
			
			_addOption = new MenuOptionVO( 'Add', add );
			_editOption = new MenuOptionVO( 'Edit', edit )
			
			menuOptionsData = [ _addOption ];
				
			_view = new NestcheckView();
			
		}
		
		override protected function build( event:FlexEvent ):void
		{
			super.build( event );
			menuEntriesList.labelFunction = nestcheckLabelFunction;
		}
		
		override protected function entriesListChangeHandler( event:ItemClickEvent ):void
		{
			view = _view;
			_view.currentState = "view";
			_view.nestcheck = NestCheck( event.item );
			
			menuOptionsData = [ _editOption ];
			
		}
		
		override protected function optionsListChangeHandler( event:ItemClickEvent ):void
		{
			view = _view;
			
			var menuOption:MenuOptionVO = MenuOptionVO( event.item );
			menuOption.method.call();
			
		}
		
		override protected function closeView( e:ComponentEvent = null ):void
		{
			switch ( _view.currentState ) {
				
				case "view":
				case "add":
					super.closeView();	
					menuOptionsData = [ _addOption ];
				break;
				
				case "edit":
					_view.currentState = "view";
					menuOptionsData = [ _editOption ];
				break;
				
			}
			
			enableControls();
			
		}
		
		override protected function menuEntriesFilterFunction( item:Object ):Boolean
		{
			if( menuEntriesList.labelFunction.call(null, EntityProxy(item)._item ).indexOf( menuEntriesFilter.text )  == -1 ) {
				return false;
			}
			
			return true;
			
		}
		
		private function add():void
		{
			_view.currentState = "add";
			disableControls();
			
		}
		
		private function edit():void
		{
			_view.currentState = "edit";
			disableControls();
		}
		
		public function nestcheckLabelFunction( nc:NestCheck ):String
		{
			return _generalDateFormatter.format( nc.checkdate );
		}
		
	}
}