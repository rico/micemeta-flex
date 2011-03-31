package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.interfaces.IContent;
	
	import flash.events.Event;
	
	public class ContentEvent extends Event
	{
		
		public static const ADD_CONTENT:String = "addContent";
		public static const REMOVE_CONTENT:String = "removeContent";
		
		private var _content:IContent;
		
		public function get content():IContent
		{
			return _content;
		}

		
		public function ContentEvent(type:String,content:IContent,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_content = content;
		}
		
		override public function clone():Event
		{
			return new ContentEvent(type, content, bubbles, cancelable);

		}
	}
}