package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;

	public class NestcheckViewMediator extends AbstractComponentMediator
	{
		
		[Inject(name="NestcheckModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
	}
}