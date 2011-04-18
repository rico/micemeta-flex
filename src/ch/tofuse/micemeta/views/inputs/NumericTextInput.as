package ch.tofuse.micemeta.views.inputs
{
	import flash.events.Event;
	
	import mx.controls.Text;
	
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	public class NumericTextInput extends BaseTextInput
	{
		public function NumericTextInput()
		{
			super();
			restrict = "0-9";
			widthInChars = 2;
			maxChars = 2;
			
			addEventListener( TextOperationEvent.CHANGE, updateNumericValue); 
		}
		
		[Bindable(Event="valueChange")]
		public function get numericValue():int
		{
			return int( this.text );
		}
		
		
		public function set numericValue( v:int ):void
		{
			this.text = v.toString();
			dispatchEvent( new Event("valueChange") );
		}
		
		private function updateNumericValue( event:TextOperationEvent ):void
		{
			dispatchEvent( new Event("valueChange") );
		}
	}
}