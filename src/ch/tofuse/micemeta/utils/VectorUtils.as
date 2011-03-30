package ch.tofuse.micemeta.utils
{
	import mx.collections.ArrayCollection;
	import mx.utils.ArrayUtil;

	public class VectorUtils
	{
		public static function toArray(obj:Object):Array 
		{
			if (!obj) {
				return [];
			} else if (obj is Array) {
				return obj as Array;
			} else if (obj is Vector.<*>) {
				var array:Array = new Array(obj.length);
				for (var i:int = 0; i < obj.length; i++) {
					array[i] = obj[i];
				}
				return array;
			} else {
				return [obj];
			}
		} 
		
		public static function toArrayCollection( vec:Object ):ArrayCollection
		{
			trace("");
			return new ArrayCollection( toArray(vec) );
		}
	}
}