package ch.tofuse.micemeta.events
{
	import ch.tofuse.micemeta.interfaces.IContent;
	
	import flash.events.Event;
	
	public class MainMenuEvent extends Event
	{
		
		public static const ADD_CONTENT:String = "addContent";
		
		private var _content:IContent;
		
		public function get content():IContent
		{
			return _content;
		}

		
		public function MainMenuEvent(type:String,content:IContent,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_content = content;
		}
		
		override public function clone():Event
		{
			return new MainMenuEvent(type, content, bubbles, cancelable);

		}
	}
}