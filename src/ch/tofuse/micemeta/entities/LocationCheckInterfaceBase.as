package ch.tofuse.micemeta.entities {
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
     
	public interface LocationCheckInterfaceBase {
	
		[Bindable(event="propertyChange")]
		function get id():String;
		function set id(value:String):void;
		
		[Bindable(event="propertyChange")]
		function get rank():int;
		function set rank(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get non_transpondered():int;
		function set non_transpondered(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get sub_adults():int;
		function set sub_adults(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups():int;
		function set pups(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_age():int;
		function set pups_age(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_male_alive():int;
		function set pups_male_alive(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_male_dead():int;
		function set pups_male_dead(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_female_alive():int;
		function set pups_female_alive(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_female_dead():int;
		function set pups_female_dead(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_unknown_alive():int;
		function set pups_unknown_alive(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get pups_unknown_dead():int;
		function set pups_unknown_dead(value:int):void;
		
		[Bindable(event="propertyChange")]
		function get new_litter():Boolean;
		function set new_litter(value:Boolean):void;
		
		[Bindable(event="propertyChange")]
		function get communal():Boolean;
		function set communal(value:Boolean):void;
		
		[Bindable(event="propertyChange")]
		function get remark():String;
		function set remark(value:String):void;
		
		[Bindable(event="propertyChange")]
		function get mice():PersistentCollection;
		function set mice(value:PersistentCollection):void;
		
		[Bindable(event="propertyChange")]
		function get litters():PersistentCollection;
		function set litters(value:PersistentCollection):void;
		
	}

}
