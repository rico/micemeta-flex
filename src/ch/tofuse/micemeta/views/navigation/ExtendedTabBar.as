package ch.tofuse.micemeta.views.navigation {
	
	import ch.tofuse.micemeta.events.ContentEvent;
	import ch.tofuse.micemeta.events.ExtendedTabBarEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.skins.button.ExtendedButtonBarSkin;
	import ch.tofuse.micemeta.skins.navigation.ExtendedTabBarSkin;
	
	import flash.events.Event;
	
	import mx.collections.IList;
	import mx.containers.ViewStack;
	
	import spark.components.ButtonBar;
	import spark.components.TabBar;
	
	public class ExtendedTabBar extends ButtonBar {
		
		[Bindable] public var closable:Boolean;
		
		public function ExtendedTabBar() {
			super();
			//setStyle("skinClass", ExtendedTabBarSkin);
			setStyle("skinClass", ExtendedButtonBarSkin);
			requireSelection = true;
		}
		
		public function setCloseableTab(index:int, value:Boolean):void {
			if (index > 0 && index < dataGroup.numElements) {
				var btn:ExtendedTabBarButton = dataGroup.getElementAt(index) as ExtendedTabBarButton;
				btn.closeable = value;
				dispatchEvent( new Event("setClosableTabChanged") );
			}
		}
		
		[Bindable(Event="setClosableTabChanged")]
		public function getCloseableTab(index:int):Boolean {
			if (index > 0 && index < dataGroup.numElements) {
				var btn:ExtendedTabBarButton = dataGroup.getElementAt(index) as ExtendedTabBarButton;
				return btn.closeable;
			}
			
			return false;
		}
		
		private function closeHandler(e:ExtendedTabBarEvent):void {
			closeTab(e.index, selectedIndex);
		}
		
		public function closeTab(closedTab:int, selectedTab:int):void {
			if (dataProvider.length == 0) return;
			
			if (dataProvider is IList) {
				//dataProvider.removeItemAt(closedTab);
				dispatchEvent( new ContentEvent( ContentEvent.REMOVE_CONTENT, IContent( dataProvider.getItemAt(closedTab) ) ) );
			} else if (dataProvider is ViewStack){
				dispatchEvent( new ContentEvent( ContentEvent.REMOVE_CONTENT, IContent( (dataProvider as ViewStack).getChildAt(closedTab) ) ) );
				//(dataProvider as ViewStack).removeChildAt(closedTab);
			}
			
			//adjust selectedIndex appropriately
			if (dataProvider.length == 0) {
				selectedIndex = -1;
			} else if (closedTab < selectedTab) {
				selectedIndex = selectedTab - 1;
			} else if (closedTab == selectedTab) {
				selectedIndex = (selectedTab == 0 ? 0 : selectedTab - 1);
			} else {
				selectedIndex = selectedTab;
			}
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == dataGroup) {
				dataGroup.addEventListener(ExtendedTabBarEvent.CLOSE_TAB, closeHandler);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == dataGroup) {
				dataGroup.removeEventListener(ExtendedTabBarEvent.CLOSE_TAB, closeHandler);
			}
		}
	}
}