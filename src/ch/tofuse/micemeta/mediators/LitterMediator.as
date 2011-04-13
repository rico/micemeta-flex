package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.AbstractEntityModel;
	import ch.tofuse.micemeta.models.BoxModel;
	import ch.tofuse.micemeta.views.components.box.BoxView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LitterMediator extends AbstractComponentMediator
	{
		
		[Inject(name="LitterModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
	}
}