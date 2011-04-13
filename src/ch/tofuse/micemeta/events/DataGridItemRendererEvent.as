package ch.tofuse.micemeta.events
{
	import flash.events.Event;
	
	public class DataGridItemRendererEvent extends Event
	{
		
		public static const REMOVE_ITEM:String = "removeItem";
		public static const EDIT_ITEM:String = "editItem";
		public static const ADD_ITEM:String = "addItem";
		public static var SHOW_ITEM:String = "showItem";
		
		public function DataGridItemRendererEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new DataGridItemRendererEvent(type,bubbles,cancelable);
		}
	}
}