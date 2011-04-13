package ch.tofuse.micemeta.views.navigation {
	
	import ch.tofuse.micemeta.events.ContentEvent;
	import ch.tofuse.micemeta.events.ExtendedTabBarEvent;
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.skins.button.ExtendedButtonBarSkin;
	
	import flash.events.Event;
	
	import mx.collections.IList;
	import mx.containers.ViewStack;
	
	import spark.components.ButtonBar;
	import spark.components.ButtonBarButton;
	import spark.components.DataGroup;
	import spark.components.TabBar;
	
	public class ExtendedTabBar extends ButtonBar {
				
		[Bindable] public var closable:Boolean;
		
		public function ExtendedTabBar() {
			super();
			setStyle("skinClass", ExtendedButtonBarSkin);
			requireSelection = true;
		}
				
		private function closeHandler(e:ExtendedTabBarEvent):void {
			closeTab(e.index, selectedIndex);
		}
		
		override public function set enabled( value:Boolean ):void
		{
			super.enabled = value;
			
			if( dataGroup ) {
				for (var i:uint=0; i<dataGroup.numElements; ++i) {
					var obj:ExtendedTabBarButton = dataGroup.getElementAt(i) as ExtendedTabBarButton;
					obj.enabled = value;
				}
			}
			
		}
		
		public function closeTab(closedTab:int, selectedTab:int):void {
			if (dataProvider.length == 0) return;
			
			if (dataProvider is IList) {
				dispatchEvent( new ContentEvent( ContentEvent.REMOVE_CONTENT, IContent( dataProvider.getItemAt(closedTab) ) ) );
			} else if (dataProvider is ViewStack){
				dispatchEvent( new ContentEvent( ContentEvent.REMOVE_CONTENT, IContent( (dataProvider as ViewStack).getChildAt(closedTab) ) ) );
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