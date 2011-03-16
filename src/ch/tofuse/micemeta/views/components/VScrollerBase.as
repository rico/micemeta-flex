package ch.tofuse.micemeta.views.components
{
	import ch.tofuse.micemeta.skins.ScrollerSkin;
	
	import spark.components.SkinnableContainer;
	import spark.layouts.VerticalLayout;
	
	public class VScrollerBase extends SkinnableContainer
	{
		
		[Bindable] public var gap:Number = 10;
		private var _layout:VerticalLayout;
		
		public function VScrollerBase()
		{
			super();
			setStyle('skinClass', ScrollerSkin);
			_layout = new VerticalLayout();
			_layout.gap = gap;
			
			layout = _layout;
		}
	}
}