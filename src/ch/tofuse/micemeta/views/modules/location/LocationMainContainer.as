package ch.tofuse.micemeta.views.modules.location
{
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	import ch.tofuse.micemeta.views.components.box.BoxView;
	import ch.tofuse.micemeta.views.components.otherlocation.OtherLocationView;
	import ch.tofuse.micemeta.vo.MenuEntryVO;
	
	import mx.collections.ArrayCollection;
	import mx.events.ItemClickEvent;
	
	public class LocationMainContainer extends ModuleContainerBase
	{
		
		private var _otherLocationView:OtherLocationView;
		private var _boxView:BoxView;
		
		public function LocationMainContainer()
		{
			super();
			showFilter = false;
			
			_otherLocationView = new OtherLocationView();
			_boxView = new BoxView();
			
			label = "Locations";
			menuEntriesData = new ArrayCollection( [
				new MenuEntryVO( 'Boxes', boxView ),
				new MenuEntryVO( 'Other Locations', otherLocationView )
			]);
			
		}
		
		override protected function entriesListChangeHandler( event:ItemClickEvent ):void
		{
			MenuEntryVO( event.item ).method.call();
		}
		
		protected function boxView():void
		{
			view = _boxView;
		}
		
		protected function otherLocationView():void
		{
			view = _otherLocationView;
		}
	}
}