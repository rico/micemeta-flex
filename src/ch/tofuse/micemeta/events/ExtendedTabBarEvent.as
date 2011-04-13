package ch.tofuse.micemeta.events {
	
	import flash.events.Event;
	
	public class ExtendedTabBarEvent extends Event {
		public static const CLOSE_TAB:String = 'closeTab';
		public static const DISABLE_BUTTONS:String = "disableButtons";
		public static const ENABLE_BUTTONS:String = "enableButtons";
		
		private var _index:int = -1;
		
		public function ExtendedTabBarEvent(type:String, index:int, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_index = index;
		}
		
		public function get index():int {
			return _index;
		}
		
		override public function clone():Event {
			return new ExtendedTabBarEvent(type,index,bubbles,cancelable);
		}
	}
}