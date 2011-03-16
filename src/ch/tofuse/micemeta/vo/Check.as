package ch.tofuse.micemeta.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class Check extends EventDispatcher
	{
		public var rank:uint;
		public var location:String;
		public var transponders:ArrayCollection = new ArrayCollection();
		public var non_transpondered:int = 0;
		public var sub_adults:int = 0;
		public var open:String = '-'; 
		
		public var pups:int = 0;
		public var pups_age:int = 0;
		public var pups_male_alive:int = 0;
		public var pups_male_dead:int = 0;
		public var pups_female_alive:int = 0;
		public var pups_female_dead:int = 0;
		public var pups_unknown_dead:int = 0;
		
		public var new_litter:Boolean = false;
		public var communal_nest:Boolean = false;
		
		public var lost_transponders_found:ArrayCollection = new ArrayCollection();
		
		public var remark:String = '';
		
		
		
		
		
	}
}