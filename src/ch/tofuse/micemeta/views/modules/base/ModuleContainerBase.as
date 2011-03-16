package ch.tofuse.micemeta.views.modules.base
{
	import ch.tofuse.micemeta.events.ComponentEvent;
	import ch.tofuse.micemeta.events.ModuleMenuEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.managers.ModuleManager;
	import ch.tofuse.micemeta.views.inputs.SearchTextInput;
	import ch.tofuse.micemeta.views.menus.modulemenu.ModuleMenuContainer;
	import ch.tofuse.micemeta.views.menus.modulemenu.ModuleMenuEntryContainer;
	import ch.tofuse.micemeta.views.menus.modulemenu.ModuleMenuLabel;
	import ch.tofuse.micemeta.views.menus.modulemenu.ModuleMenuList;
	import ch.tofuse.micemeta.views.renderers.ModuleMenuEntriesItemRenderer;
	import ch.tofuse.micemeta.views.renderers.ModuleMenuOptionsItemRenderer;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HDividedBox;
	import mx.controls.Spacer;
	import mx.core.ClassFactory;
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	
	import org.davekeen.flextrine.orm.EntityManager;
	import org.davekeen.flextrine.orm.IEntityRepository;
	
	import spark.components.NavigatorContent;
	import spark.layouts.BasicLayout;
	
	public class ModuleContainerBase extends NavigatorContent implements IContent
	{
		
		[Bindable] public var showFilter:Boolean = true;
		[Bindable] public var showList:Boolean = true;
		[Bindable] public var showOptions:Boolean = true;
		
		protected var repository:IEntityRepository;
		private var _em:EntityManager;
		
		private var _viewable:Boolean = false;
		private var _moduleManager:ModuleManager;
		
		private var _view:IVisualElement;
		
		private var _main:HDividedBox;
		
		protected var _menu:ModuleMenuContainer;
		
		private var _menuEntriesFilterContainer:ModuleMenuEntryContainer;
		private var _menuEntriesFilter:SearchTextInput;
		private var _menuEntriesFilterLabel:ModuleMenuLabel;
		
		private var _menuEntriesListLabel:ModuleMenuLabel;
		private var _menuEntriesList:ModuleMenuList;
		
		private var _menuOptionsLabel:ModuleMenuLabel;
		private var _menuOptionsList:ModuleMenuList;
		
		private var _content:ModuleContainerContent;
		
		protected var _addInstanceOnStart:Boolean;
		
		
		public function ModuleContainerBase()
		{
			super();
			addEventListener( FlexEvent.CREATION_COMPLETE, build );
			
			percentWidth = 100;
			percentHeight = 100;
			
			/* MAIN */
			_main = new HDividedBox();
			_main.percentWidth = 100;
			_main.percentHeight = 100;
			_main.liveDragging = true;
			
			addElement( _main );
			
			/* MENU */
			_menu = new ModuleMenuContainer();
			_menu.width = 200;
			_menu.minWidth = 150;
			_menu.maxWidth = 250;
			_menu.percentHeight = 100;
			
			_main.addElement( _menu );
			
			/* filter label */
			_menuEntriesFilterLabel = new ModuleMenuLabel();
			_menuEntriesFilterLabel.label = "FILTER";
			
			_menu.addElement( _menuEntriesFilterLabel);
			
			/* filter */
			_menuEntriesFilterContainer = new ModuleMenuEntryContainer();
			_menuEntriesFilterContainer.insetLeft = 15;
			
			_menuEntriesFilter = new SearchTextInput();
			_menuEntriesFilter.percentWidth = 100;
			_menuEntriesFilter.height = 22;
			_menuEntriesFilterContainer.addElement( _menuEntriesFilter );
			
			_menu.addElement( _menuEntriesFilterContainer );
			
			/* spacer */
			var vspacer:Spacer = new Spacer();
			vspacer.height = 10;
			_menu.addElement( vspacer );
			
			/* entries list */ 
			_menuEntriesListLabel = new ModuleMenuLabel();
			_menuEntriesListLabel.label = "LIST";
			
			_menu.addElement( _menuEntriesListLabel );
			
			_menuEntriesList = new ModuleMenuList();
			_menuEntriesList.itemRenderer = new ClassFactory( ModuleMenuEntriesItemRenderer );
			_menuEntriesList.addEventListener( ItemClickEvent.ITEM_CLICK, entriesListChangeHandler );
			_menuEntriesList.percentWidth = 100;
			_menuEntriesList.percentHeight = 100;
			//_menuList.dataProvider = new ArrayCollection();
			
			_menu.addElement( _menuEntriesList );
			
			/* options list */
			_menuOptionsLabel = new ModuleMenuLabel();
			_menuOptionsLabel.label = "OPTIONS";
			
			_menu.addElement( _menuOptionsLabel );
			
			_menuOptionsList = new ModuleMenuList();
			_menuOptionsList.dataProvider = new ArrayCollection();
			_menuOptionsList.itemRenderer = new ClassFactory( ModuleMenuOptionsItemRenderer );
			_menuOptionsList.addEventListener( ItemClickEvent.ITEM_CLICK, optionsListChangeHandler );
			_menuOptionsList.percentWidth = 100;
			
			_menu.addElement( _menuOptionsList );
			
			/* CONTENT */
			_content = new ModuleContainerContent();
			_content.layout = new BasicLayout();
			_content.percentWidth = 100;
			_content.percentHeight = 100;
			
			_main.addElement( _content );
			
			_content.addEventListener( ModuleMenuEvent.DISABLE_MENU, disableMenu );
			_content.addEventListener( ModuleMenuEvent.ENABLE_MENU, enableMenu );
			
			_content.addEventListener( ModuleMenuEvent.DISABLE_FILTER, disableFilter );
			_content.addEventListener( ModuleMenuEvent.ENABLE_FILTER, enableFilter );
			
			_content.addEventListener( ModuleMenuEvent.DISABLE_LIST, disableList );
			_content.addEventListener( ModuleMenuEvent.ENABLE_LIST, enableList );
			
			_content.addEventListener( ModuleMenuEvent.DISABLE_OPTIONS, disableOptions );
			_content.addEventListener( ModuleMenuEvent.ENABLE_OPTIONS, enableOptions );
			
			_content.addEventListener( ModuleMenuEvent.DISABLE_CONTROLS, disableControls );
			_content.addEventListener( ModuleMenuEvent.ENABLE_CONTROLS, enableControls );
			
			_content.addEventListener( ComponentEvent.DONE, done );
		}
		
		protected function build( event:FlexEvent ):void
		{
			setLabel();
			
			_menuEntriesFilterLabel.includeInLayout = showFilter;
			_menuEntriesFilterLabel.visible = showFilter;
			_menuEntriesFilterContainer.includeInLayout = showFilter;
			_menuEntriesFilterContainer.visible = showFilter;
			
			_menuOptionsLabel.includeInLayout = menuOptionsData.length != 0;
			_menuOptionsLabel.visible = menuOptionsData.length != 0;
			_menuOptionsList.includeInLayout = menuOptionsData.length != 0;
			_menuOptionsList.visible = menuOptionsData.length != 0;
			
			_menuEntriesListLabel.includeInLayout = showList;
			_menuEntriesListLabel.visible = showList;
			_menuEntriesList.includeInLayout = showList;
			_menuEntriesList.visible = showList;
			
			_menuOptionsLabel.includeInLayout = showOptions;
			_menuOptionsLabel.visible = showOptions;
			_menuOptionsList.includeInLayout = showOptions;
			_menuOptionsList.visible = showOptions;
			
		}
		
		public function get main():HDividedBox
		{
			return _main;
		}
		
		public function get menu():ModuleMenuContainer
		{
			return _menu;
		}
		
		public function get content():ModuleContainerContent
		{
			return _content;
		}
		
		
		public function get menuEntriesFilter():SearchTextInput
		{
			return _menuEntriesFilter;
		}
		
		public function set moduleManager( mm:ModuleManager ):void
		{
			_moduleManager = mm;
		}
		
		protected function setLabel():void
		{
			_menuEntriesListLabel.label = label.toUpperCase();
		}
		
		public function get menuEntriesList():ModuleMenuList
		{
			return _menuEntriesList;
		}
		
		[Bindable(Event="menuEntriesDataChange")]
		public function get menuEntriesData():ArrayCollection
		{
			return ArrayCollection( _menuEntriesList.dataProvider );
		}

		public function set menuEntriesData(value:ArrayCollection):void
		{
			_menuEntriesList.dataProvider = value;
			dispatchEvent( new Event( "menuListDataChange" ) );
		}
		
		protected function entriesListChangeHandler( event:ItemClickEvent ):void
		{
				
		}
		
		public function get menuOptionsList():ModuleMenuList
		{
			return _menuOptionsList;
		}
		
		[Bindable(Event="menuOptionsDataChange")]
		public function get menuOptionsData():ArrayCollection
		{
			if( _menuOptionsList.dataProvider ) {
				return ArrayCollection( _menuOptionsList.dataProvider );
			} 
			
			return new ArrayCollection();
			
		}
		
		public function set menuOptionsData(value:ArrayCollection):void
		{
			_menuOptionsList.dataProvider = value;
			dispatchEvent( new Event( "menuOptionsDataChange" ) );
		}
		
		protected function optionsListChangeHandler( event:ItemClickEvent ):void
		{
			
		}
		
		public function set view( element:IVisualElement ):void
		{
			if( element && element != _view ) {
				_content.removeAllElements();
				_content.addElement( element );
				_view = element;
				dispatchEvent( new Event("viewChange") );
			}
			
		}
		
		[Bindable(Event="viewChange")]
		public function get view():IVisualElement
		{ 
			return _view;
		}
		
		private function clearView():void
		{
			_content.removeAllElements();
		}
		
		public function asDisplayObject():DisplayObject
		{
			return this;
		}
		
		public function asNavigatorContent():NavigatorContent
		{
			return this;
		}
		
		public function set addInstanceOnStart( aios:Boolean ):void
		{
			_addInstanceOnStart = aios;
		}
		
		public function get addInstanceOnStart():Boolean
		{
			return _addInstanceOnStart;			
		}

		public function get em():EntityManager
		{
			if( !_em ) {
				_em = EntityManager.getInstance();
			}
			
			return _em;
		}
		
		protected function disableMenu( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			_menu.enabled = false;
		}
		
		protected function enableMenu( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			_menu.enabled = true;
		}
		
		protected function hideMenu( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			removeChild( _menu );
		}
		
		protected function showMenu( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			addChild( _menu );
		}
		
		protected function disableFilter( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			_menuEntriesFilter.enabled = false;
		}
		
		protected function enableFilter( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			_menuEntriesFilter.enabled = true;
		}
		
		protected function disableList( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			_menuEntriesList.enabled = false;
		}
		
		protected function enableList( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			_menuEntriesList.enabled = true;
		}
		
		protected function disableOptions( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			_menuOptionsList.enabled = false;
		}
		
		protected function enableOptions( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			_menuOptionsList.enabled = true;
		}
		
		protected function disableControls( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			disableList();
			disableOptions();
			disableFilter();
		}
		
		protected function enableControls( e:ModuleMenuEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			
			enableList();
			enableOptions();
			enableFilter();
		}
		
		protected function done( e:ComponentEvent = null ):void
		{
			if( e ) {
				e.stopImmediatePropagation();
			}
			enableControls();
			clearView();
		}

	}
}