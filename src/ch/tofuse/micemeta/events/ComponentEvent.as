package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class ComponentEvent extends Event
	{
		
		public static const DONE:String = "done";
		
		public function ComponentEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}