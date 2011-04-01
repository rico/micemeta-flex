package ch.tofuse.micemeta.views.inputs
{
	import ch.tofuse.micemeta.skins.input.SearchTextInputSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	import spark.primitives.BitmapImage;
	
	public class SearchTextInput extends TextInput
	{
		[Embed(source="ch/tofuse/micemeta/assets/img/search.png")] 
		[Bindable] 
		public var searchIcon:Class;
		
		[SkinPart(required="true")]
		[Bindable] public var icon:BitmapImage;	
		
		[SkinPart(required="false")]
		public var clearButton:Button;
		
		public function SearchTextInput()
		{
			super();
			setStyle( "focusAlpha", null );
			setStyle( "skinClass", SearchTextInputSkin );
			
			//watch for programmatic changes to text property
			this.addEventListener(FlexEvent.VALUE_COMMIT, textChangedHandler, false, 0, true);
			
			//watch for user changes (aka typing) to text property
			this.addEventListener(TextOperationEvent.CHANGE, textChangedHandler, false, 0, true);
		}
		
		private function textChangedHandler(e:Event):void {
			if (clearButton) {
				clearButton.visible = (text.length > 0);
			}
		}
		
		private function clearClick(e:MouseEvent):void {
			text = '';
			dispatchEvent( new TextOperationEvent( TextOperationEvent.CHANGE) );
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == clearButton) {
				clearButton.addEventListener(MouseEvent.CLICK, clearClick);
				clearButton.visible = (text != null && text.length > 0);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == clearButton) {
				clearButton.removeEventListener(MouseEvent.CLICK, clearClick);
			}
		}
		
		
	}
}