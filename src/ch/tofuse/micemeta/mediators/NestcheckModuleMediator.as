package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.entities.ILocationCheck;
	import ch.tofuse.micemeta.entities.NestCheckEntity;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	
	import mx.events.ModuleEvent;
	
	public class NestcheckModuleMediator extends AbstractModuleMediator
	{
		
		[Inject(name="NestcheckModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			view.menuEntriesData = model.repository.entities;
			
		}
		
		override protected function removeEntityHandler( e:EntityMediatorEvent ):void
		{
			var nc:NestCheckEntity = e.entity;
			
			// delete location checks
			for each (var lc:ILocationCheck in nc.locationChecks)
			{
				model.remove( lc );
			}
			
			nc.locationChecks.removeAll();
			model.remove( nc );
			model.flush();
			
		}

	}
}