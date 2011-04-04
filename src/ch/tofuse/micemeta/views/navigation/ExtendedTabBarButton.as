package ch.tofuse.micemeta.views.navigation {
	
	
	import ch.tofuse.micemeta.events.ExtendedTabBarEvent;
	import ch.tofuse.micemeta.skins.button.ExtendedTabBarButtonSkin;
	
	import flash.events.MouseEvent;
	
	import mx.states.OverrideBase;
	
	import spark.components.Button;
	import spark.components.ButtonBarButton;
	
	[Event('closeTab',type='ch.tofuse.micemta.events.ExtendedTabBarEvent')]
	
	public class ExtendedTabBarButton extends ButtonBarButton 
	{
		
		[SkinPart("false")]
		public var closeButton:Button;
		
		private var _closeable:Boolean = true;
		
		public function ExtendedTabBarButton() {
			super();
			setStyle("skinClass", ExtendedTabBarButtonSkin);
			allowDeselection = false;
			
			//NOTE: this enables the button's children (aka the close button) to receive mouse events
			this.mouseChildren = true;
			
		}
		
		[Bindable]
		public function get closeable():Boolean {
			return _closeable;
		}
		public function set closeable(val:Boolean):void {
			if (_closeable != val) {
				_closeable = val;
				closeButton.visible = val;
				//labelDisplay.right = (val ? 30 : 14);
			}
		}
		
		private function closeHandler(e:MouseEvent):void {
			dispatchEvent(new ExtendedTabBarEvent(ExtendedTabBarEvent.CLOSE_TAB, itemIndex, true));
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == closeButton) {
				closeButton.addEventListener(MouseEvent.CLICK, closeHandler);
				closeButton.visible = closeable;
			} 
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == closeButton) {
				closeButton.removeEventListener(MouseEvent.CLICK, closeHandler);
			}
		}
	}
}