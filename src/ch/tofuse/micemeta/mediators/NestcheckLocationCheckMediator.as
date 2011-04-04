package ch.tofuse.micemeta.mediators
{
	public class NestcheckLocationCheckMediator extends AbstractComponentMediator
	{
		public function NestcheckLocationCheckMediator()
		{
			[Inject(name="LocationCheckModel")]
			override public function set model(m:IEntityModelInterface):void
			{
				super.model = m;
			}
		}
	}
}