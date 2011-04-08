package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class AutoCompleteListEvent extends Event
	{
		
		public static const ITEM_ADDED:String = "itemAdded";
		public static const ITEM_REMOVED:String = "itemRemoved";
		
		private var _item:Object;
		
		
		public function AutoCompleteListEvent(type:String, item:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_item = item;
		}
		
		public function get item():Object
		{
			return _item;
		}
		
		override public function clone():Event
		{
			return new AutoCompleteListEvent(type,item,bubbles,cancelable);
		}
	}
}