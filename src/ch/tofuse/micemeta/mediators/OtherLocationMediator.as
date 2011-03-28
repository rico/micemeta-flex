package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.OtherLocationModel;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.otherlocation.OtherLocationView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class OtherLocationMediator extends AbstractEntityMediator
	{
		public function OtherLocationMediator()
		{
			super();
		}		
		
		[Inject(name="OtherLocationModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
			
	}
}