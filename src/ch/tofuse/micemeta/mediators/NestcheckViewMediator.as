package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.entities.NestCheckEntity;
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.components.nestcheck.NestcheckView;

	public class NestcheckViewMediator extends AbstractComponentMediator
	{
		
		private var _view:NestcheckView;
		
		[Inject(name="NestcheckModel")]
		override public function set model(m:IEntityModelInterface):void
		{
			super.model = m;
		}
		
		/*[Inject]
		override public function set view( v:AbstractComponentView ):void
		{
			super.view = v
			_view = NestcheckView( v );	
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			if( !_view.nestcheck && view.mode == 'add' ) {
				_view.nestcheck = new NestCheckEntity();
				handlePersist( new EntityMediatorEvent( EntityMediatorEvent.ENTITY_PERSIST, _view.nestcheck ) );
			}
		}*/
	}
}