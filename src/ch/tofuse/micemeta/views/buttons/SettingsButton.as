package ch.tofuse.micemeta.views.buttons
{
	import ch.tofuse.micemeta.skins.button.SettingsButtonSkin;
	
	import mx.controls.Image;
	
	import spark.components.Button;
	
	[Style(name="paddingLeft",type="Number")]
	[Style(name="paddingRight",type="Number")]
	[Style(name="paddingTop",type="Number")]
	[Style(name="paddingBottom",type="Number")]
	
	public class SettingsButton extends Button
	{
		
		[Embed(source="ch/tofuse/micemeta/assets/img/settings.png")] 
		[Bindable] 
		public var settingsIcon:Class; 
		
		[SkinPart(required="true")]
		[Bindable] public var icon:Image;	
		
		
		public function SettingsButton()
		{
			super();
			percentHeight = 100;
			width = 50;
			setStyle("skinClass", SettingsButtonSkin);
		}
		
		
		override public function get label():String
		{
			return "Settings";
		}
		
	}
}