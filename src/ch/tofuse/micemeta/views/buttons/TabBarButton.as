package ch.tofuse.micemeta.views.buttons
{
	import ch.tofuse.micemeta.skins.button.TabBarButtonCloseButtonPendingChangesSkin;
	import ch.tofuse.micemeta.skins.button.TabBarButtonCloseButtonSkin;
	
	import flash.events.Event;
	
	import spark.components.Button;
	
	[SkinState("up")]
	[SkinState("over")]
	[SkinState("down")]
	[SkinState("disabled")]
	[SkinState("pendingChangesUp")]
	[SkinState("pendingChangesOver")]
	[SkinState("pendingChangesDown")]
	public class TabBarButton extends Button
	{
		
		private var _pendingChanges:Boolean;
		
		public function TabBarButton()
		{
			super();
			setStyle("skinClass", TabBarButtonCloseButtonSkin);
		}
		
		[Bindable(Event="pendingChanged")]
		public function get pendingChanges():Boolean
		{
			return _pendingChanges;
		}

		public function set pendingChanges(value:Boolean):void
		{
			if( _pendingChanges != value ) {
				_pendingChanges = value;
				
				if( _pendingChanges) {
					setStyle("skinClass", TabBarButtonCloseButtonPendingChangesSkin);
					enabled = false;
					toolTip = "You must save the changes by hittig the done button before you can close this tab";
				} else {
					setStyle("skinClass", TabBarButtonCloseButtonSkin);
					toolTip = '';
					enabled = true;
				}
				dispatchEvent( new Event("pendingChanged") )	
			}
			
		}
		

	}
}