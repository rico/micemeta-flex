package ch.tofuse.micemeta.events
{

	
	import flash.events.Event;
	/**
	 * <P>Custom event class.</P>
	 * stores custom data in the <code>data</code> variable.
	 */	
	public class AutoCompleteTextInputEvent extends Event{
		
		public static const SELECT:String = "select";
		public static const CONFIRM_SELECTION:String = "confirmSelection";
		
		public var data:Object;

		public function AutoCompleteTextInputEvent(type:String, d:Object, bubbles:Boolean = false, cancelable:Boolean = false){
			
			super(type, bubbles,cancelable);
			data = d;
		}

	}
}