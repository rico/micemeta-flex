package ch.tofuse.micemeta.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class MenuOptionVO extends EventDispatcher
	{
		[Bindable] private var _label:String;
		[Bindable] private var _method:Function;
		
		public function MenuOptionVO( l:String, m:Function )
		{
			_label = l;
			_method = m;
			
			dispatchEvent( new Event("dataChange") );
		
		}
		
		[Bindable(Event="dataChange")]
		public function get label():String
		{
			return _label;
		}
		
		[Bindable(Event="dataChange")]
		public function get method():Function
		{
			return _method;
		}
		
		
		
	}
}