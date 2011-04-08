package ch.tofuse.micemeta.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;

	public class DataUtils
	{
		public static function getItemIndexByPropertyValue( prop:String, value:String, data:ArrayCollection ):uint
		{
			for (var i:uint ; i < data.length; i++ ) {
				
				if( data[ i ][ prop ] == value ) {
					return i;
				}
			}
			
			return 0;
		}	
		
	
		public static function copyOverObject( objToCopy:Object, registerAlias:Boolean = false ):Object
		{
			if( registerAlias ) {
				var className:String = getQualifiedClassName( objToCopy );
				registerClassAlias( className, (getDefinitionByName( className ) as Class ) );
			}
			
			return ObjectUtil.copy( objToCopy );
		}
		
		public static function copyOverArray( arr:Array ):Array
		{
			var newArr:Array = [];
			var i:int;
			
			for ( i; i < arr.length; i++ ) {
				newArr.push( copyOverObject( arr[i], true ) );
			}
			
			return newArr;
			
		}
	}
}