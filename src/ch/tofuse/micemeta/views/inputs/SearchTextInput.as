package ch.tofuse.micemeta.views.inputs
{
	import ch.tofuse.micemeta.skins.input.SearchTextInputSkin;
	
	import spark.components.TextInput;
	import spark.primitives.BitmapImage;
	
	public class SearchTextInput extends TextInput
	{
		[Embed(source="ch/tofuse/micemeta/assets/img/search.png")] 
		[Bindable] 
		public var searchIcon:Class;
		
		[SkinPart(required="true")]
		[Bindable] public var icon:BitmapImage;	
		
		public function SearchTextInput()
		{
			super();
			setStyle( "focusAlpha", null );
			setStyle( "skinClass", SearchTextInputSkin );
		}
	}
}