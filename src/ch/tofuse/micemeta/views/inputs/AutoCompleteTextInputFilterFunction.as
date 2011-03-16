package ch.tofuse.micemeta.views.inputs
{
	public class AutoCompleteTextInputFilterFunction extends AutoCompleteTextInput
	{
		
		private var _filterFunction:Function;

		
		public function AutoCompleteTextInputFilterFunction():void
		{
			super();
		}
		
		override public function labelsFilterFunction( item:Object ):Boolean
		{
			
			if( !super.labelsFilterFunction( item ) ) {
				return false;
			}
			
			if( !_filterFunction.call( this, item ) ) {
				return false;
			}
			
			return true;
		}
		
		public function get filterFunction():Function
		{
			return _filterFunction;
		}
		
		public function set filterFunction(value:Function):void
		{
			_filterFunction = value;
		}
		
	}
}