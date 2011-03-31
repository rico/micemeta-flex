package ch.tofuse.micemeta.views.buttons
{
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.skins.button.ContentButtonSkin;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	
	import mx.controls.Image;
	
	import spark.components.Button;
	import spark.primitives.BitmapImage;
	
	[Style(name="paddingLeft",type="Number")]
	[Style(name="paddingRight",type="Number")]
	[Style(name="paddingTop",type="Number")]
	[Style(name="paddingBottom",type="Number")]
	
	public class ModuleButton extends ContentButton
	{
		
		[Embed(source="ch/tofuse/micemeta/assets/img/modules.png")] 
		[Bindable] 
		override public var modulesIcon:Class; 
		
	}
}