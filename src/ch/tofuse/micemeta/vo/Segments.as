package ch.tofuse.micemeta.vo
{
	import mx.collections.ArrayCollection;

	public class Segments extends ArrayCollection
	{
		public function Segments()
		{
			super([
				{id:'no-val', label:'-'},
				{id:'a', label:'A'},
				{id:'b', label:'B'},
				{id:'c', label:'C'},
				{id:'d', label:'D'}
			]);
		}
	}
}