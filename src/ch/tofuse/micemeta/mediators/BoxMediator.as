package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.models.AbstractEntityModel;
	import ch.tofuse.micemeta.models.BoxModel;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.box.BoxView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class BoxMediator extends AbstractComponentMediator
	{
		
		[Inject]
		override public function set view( v:AbstractComponentView ):void
		{
			super.view = v;
		}
		
		[Inject(name="BoxModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
	}
}