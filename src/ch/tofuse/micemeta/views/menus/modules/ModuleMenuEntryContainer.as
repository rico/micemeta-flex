package ch.tofuse.micemeta.views.menus.modules
{
	import org.osmf.layout.PaddingLayoutFacet;
	
	import spark.components.Group;
	import spark.layouts.HorizontalLayout;
	
	public class ModuleMenuEntryContainer extends Group
	{
		
		private var _layout:HorizontalLayout;
		
		public function ModuleMenuEntryContainer()
		{
			super();
			layoutDirection = "ltr";
			_layout = new HorizontalLayout();
			_layout.paddingRight = 10;
			
			layout = _layout;
			
		}
		
		public function set insetLeft( il:Number ):void
		{
			_layout.paddingLeft = il;
		}
	}
}