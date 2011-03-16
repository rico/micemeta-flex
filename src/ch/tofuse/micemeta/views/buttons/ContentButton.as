package ch.tofuse.micemeta.views.buttons
{
	import ch.tofuse.micemeta.interfaces.IContent;
	import ch.tofuse.micemeta.skins.button.ContentButtonSkin;
	import ch.tofuse.micemeta.views.modules.base.ModuleContainerBase;
	
	import mx.controls.Image;
	
	import spark.components.Button;
	import spark.primitives.BitmapImage;
	
	[Style(name="paddingLeft",type="Number")]
	[Style(name="paddingRight",type="Number")]
	[Style(name="paddingTop",type="Number")]
	[Style(name="paddingBottom",type="Number")]
	
	public class ContentButton extends Button
	{
		
		[Bindable] 
		public var modulesIcon:Class; 
		
		[SkinPart(required="true")]
		[Bindable] public var icon:Image;	
		
		private var _component:IContent;
		
		public function ContentButton( )
		{
			super();
			percentHeight = 100;
			width = 50;
			setStyle("skinClass", ContentButtonSkin);
		}
		
		public function set component( c:IContent ):void
		{
			_component = c;
		}
		
		public function get component():IContent
		{
			return _component;
		}
		
		override public function get label():String
		{
			return _component.label;
		}
		
	}
}