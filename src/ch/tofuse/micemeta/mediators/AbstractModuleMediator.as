package ch.tofuse.micemeta.mediators
{
	import ch.tofuse.micemeta.events.EntityManagerEvent;
	import ch.tofuse.micemeta.events.EntityMediatorEvent;
	import ch.tofuse.micemeta.interfaces.IEntityModelInterface;
	import ch.tofuse.micemeta.views.components.AbstractComponentView;
	import ch.tofuse.micemeta.views.modules.AbstractModuleView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AbstractModuleMediator extends Mediator
	{
		private var _view:AbstractModuleView;
		private var _model:IEntityModelInterface;
		
		public function AbstractModuleMediator()
		{
			super();
		}
		
		[Inject]
		public function set view( v:AbstractModuleView ):void
		{
			_view = v;	
		}
		
		public function get view():AbstractModuleView
		{
			return _view;
		}
		
		public function set model( m:IEntityModelInterface ):void
		{
			_model = m;
		}
		
		public function get model():IEntityModelInterface
		{
			return _model;
		}
		
		override public function onRegister():void
		{
			_view.repository = _model.repository;
			_view.entities = _model.repository.entities;
			
		}
		
	}
}