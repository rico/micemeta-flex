package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class ComponentEvent extends Event
	{
		
		public static const CLOSE_VIEW:String = "closeView";
		
		public function ComponentEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ComponentEvent(type, bubbles, cancelable);
			
		}
	}
}