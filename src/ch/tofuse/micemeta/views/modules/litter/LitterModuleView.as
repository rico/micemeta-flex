package ch.tofuse.micemeta.views.modules.litter
{
	
	import ch.tofuse.micemeta.views.components.litter.LitterView;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	
	public class LitterModuleView extends AbstractModuleView
	{
		
		private var _litterView:LitterView;
		
		public function LitterModuleView()
		{
			
			super( false );
			
			_litterView = new LitterView();
			view = _litterView;
			label = "Litters";
			
		}
		
	}
}