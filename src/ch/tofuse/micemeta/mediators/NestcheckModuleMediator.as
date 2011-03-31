package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	public class NestcheckModuleMediator extends AbstractModuleMediator
	{
		
		[Inject(name="NestcheckModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
		
		override public function onRegister():void
		{
			view.repository = model.repository;
			view.entities = model.repository.entities;
			view.menuEntriesData = view.entities;
		}
	}
}