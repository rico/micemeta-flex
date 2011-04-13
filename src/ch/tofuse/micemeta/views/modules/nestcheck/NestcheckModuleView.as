package ch.tofuse.micemeta.views.modules.nestcheck
{
	import ch.tofuse.micemeta.entities.NestCheckEntity;
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.formatters.GeneralDateFormatter;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	import ch.tofuse.micemeta.vo.MenuOptionVO;
	
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	
	import org.davekeen.flextrine.orm.EntityProxy;
	
	public class NestcheckModuleView extends AbstractModuleView
	{
		
		private var _view:NestcheckView;
		private var _options:Array; 
		private var _generalDateFormatter:GeneralDateFormatter;
		
		private var _addOption:MenuOptionVO;
		private var _editOption:MenuOptionVO;
		private var _deleteOption:MenuOptionVO;
		
		
		public function NestcheckModuleView()
		{
			super();
			
			_generalDateFormatter = new GeneralDateFormatter();
			
			label = "Nestchecks";
			
			_addOption = new MenuOptionVO( 'Add', add );
			_editOption = new MenuOptionVO( 'Edit', edit )
			_deleteOption = new MenuOptionVO( 'Delete', remove );	
			
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
			_view.nestcheck = NestCheckEntity( event.item );
			
			menuOptionsData = [ _editOption, _deleteOption ];
			
		}
		
		override protected function optionsListChangeHandler( event:ItemClickEvent ):void
		{
			view = _view;
			
			var menuOption:MenuOptionVO = MenuOptionVO( event.item );
			menuOption.method.call();
			
		}
		
		override protected function closeView( e:ComponentEvent = null ):void
		{
			switch ( _view.mode ) {
				
				case "view":
				case "add":
					super.closeView();	
					menuOptionsData = [ _addOption ];
				break;
				
				case "edit":
					_view.mode = "view";
					menuOptionsData = [ _editOption, _deleteOption ];
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
			_view.mode = "new";
			disableControls();
			
		}
		
		private function edit():void
		{
			_view.mode = "edit";
			disableControls();
		}
		
		private function remove():void
		{
			dispatchEvent( new EntityMediatorEvent( EntityMediatorEvent.ENTITY_REMOVE, _view.nestcheck, true ) );
			closeView();
			
		}
		
		public function nestcheckLabelFunction( nc:NestCheckEntity ):String
		{
			return _generalDateFormatter.format( nc.checkdate );
		}
		
	}
}