package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;
	import ch.tofuse.micemeta.entities.OtherLocationEntity;
	import ch.tofuse.micemeta.entities.NestCheckEntity;

	[Bindable]
	public class OtherLocationCheckEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var savedState:Dictionary;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get rank():int { checkIsInitialized("rank"); return _rank; }
		public function set rank(value:int):void { _rank = value; }
		private var _rank:int;
		
		public function get non_transpondered():int { checkIsInitialized("non_transpondered"); return _non_transpondered; }
		public function set non_transpondered(value:int):void { _non_transpondered = value; }
		private var _non_transpondered:int;
		
		public function get sub_adults():int { checkIsInitialized("sub_adults"); return _sub_adults; }
		public function set sub_adults(value:int):void { _sub_adults = value; }
		private var _sub_adults:int;
		
		public function get pups():int { checkIsInitialized("pups"); return _pups; }
		public function set pups(value:int):void { _pups = value; }
		private var _pups:int;
		
		public function get pups_age():int { checkIsInitialized("pups_age"); return _pups_age; }
		public function set pups_age(value:int):void { _pups_age = value; }
		private var _pups_age:int;
		
		public function get pups_male_alive():int { checkIsInitialized("pups_male_alive"); return _pups_male_alive; }
		public function set pups_male_alive(value:int):void { _pups_male_alive = value; }
		private var _pups_male_alive:int;
		
		public function get pups_male_dead():int { checkIsInitialized("pups_male_dead"); return _pups_male_dead; }
		public function set pups_male_dead(value:int):void { _pups_male_dead = value; }
		private var _pups_male_dead:int;
		
		public function get pups_female_alive():int { checkIsInitialized("pups_female_alive"); return _pups_female_alive; }
		public function set pups_female_alive(value:int):void { _pups_female_alive = value; }
		private var _pups_female_alive:int;
		
		public function get pups_female_dead():int { checkIsInitialized("pups_female_dead"); return _pups_female_dead; }
		public function set pups_female_dead(value:int):void { _pups_female_dead = value; }
		private var _pups_female_dead:int;
		
		public function get pups_unknown_alive():int { checkIsInitialized("pups_unknown_alive"); return _pups_unknown_alive; }
		public function set pups_unknown_alive(value:int):void { _pups_unknown_alive = value; }
		private var _pups_unknown_alive:int;
		
		public function get pups_unknown_dead():int { checkIsInitialized("pups_unknown_dead"); return _pups_unknown_dead; }
		public function set pups_unknown_dead(value:int):void { _pups_unknown_dead = value; }
		private var _pups_unknown_dead:int;
		
		public function get new_litter():Boolean { checkIsInitialized("new_litter"); return _new_litter; }
		public function set new_litter(value:Boolean):void { _new_litter = value; }
		private var _new_litter:Boolean;
		
		public function get communal():Boolean { checkIsInitialized("communal"); return _communal; }
		public function set communal(value:Boolean):void { _communal = value; }
		private var _communal:Boolean;
		
		public function get remark():String { checkIsInitialized("remark"); return _remark; }
		public function set remark(value:String):void { _remark = value; }
		private var _remark:String;
		
		[Association(side="owning", oppositeAttribute="locationChecks", oppositeCardinality="*")]
		public function get mice():PersistentCollection { checkIsInitialized("mice"); return _mice; }
		public function set mice(value:PersistentCollection):void { _mice = value; }
		private var _mice:PersistentCollection;
		
		[Association(side="owning", oppositeAttribute="locationChecks", oppositeCardinality="*")]
		public function get litters():PersistentCollection { checkIsInitialized("litters"); return _litters; }
		public function set litters(value:PersistentCollection):void { _litters = value; }
		private var _litters:PersistentCollection;
		
		[Association(side="owning")]
		public function get otherLocation():OtherLocationEntity { checkIsInitialized("otherLocation"); return _otherLocation; }
		public function set otherLocation(value:OtherLocationEntity):void { _otherLocation = value; }
		private var _otherLocation:OtherLocationEntity;
		
		[Association(side="owning", oppositeAttribute="other_location_checks", oppositeCardinality="*")]
		public function get nestcheck():NestCheckEntity { checkIsInitialized("nestcheck"); return _nestcheck; }
		public function set nestcheck(value:NestCheckEntity):void { (value) ? value.flextrine::addValue('other_location_checks', this) : ((_nestcheck) ? _nestcheck.flextrine::removeValue('other_location_checks', this) : null); _nestcheck = value; }
		private var _nestcheck:NestCheckEntity;
		
		public function OtherLocationCheckEntityEntityBase() {
			if (!_mice) _mice = new PersistentCollection(null, true, "mice", this);
			if (!_litters) _litters = new PersistentCollection(null, true, "litters", this);
		}
		
		override public function toString():String {
			return "[OtherLocationCheckEntity id=" + id + "]";
		}
		
		private function checkIsInitialized(property:String):void {
			if (!isInitialized__ && isUnserialized__) {
				if (!flextrine::itemPendingError) {
					flextrine::itemPendingError = new ItemPendingError("ItemPendingError - initializing entity " + this);
					dispatchEvent(new EntityEvent(EntityEvent.INITIALIZE_ENTITY, property, flextrine::itemPendingError));
				}
			}
		}
		
		flextrine function setValue(attributeName:String, value:*):void {
			if (isInitialized__) {
				if (this["_" + attributeName] is PersistentCollection)
					throw new Error("Internal error - Flextrine attempted to setValue on a PersistentCollection.");
					
				var propertyChangeEvent:PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this, attributeName, this[attributeName], value);
				
				this["_" + attributeName] = value;
				
				dispatchEvent(propertyChangeEvent);
			}
		}
		
		flextrine function addValue(attributeName:String, value:*):void {
			if (isInitialized__) {
				if (!(this["_" + attributeName] is PersistentCollection))
					throw new Error("Internal error - Flextrine attempted to addValue on a non-PersistentCollection.");
					
				this["_" + attributeName].flextrine::addItemNonRecursive(value);
			}
		}
		
		flextrine function removeValue(attributeName:String, value:*):void {
			if (isInitialized__) {
				if (!(this["_" + attributeName] is PersistentCollection))
					throw new Error("Internal error - Flextrine attempted to removeValue on a non-PersistentCollection.");
				
				this["_" + attributeName].flextrine::removeItemNonRecursive(value);
			}
		}
		
		flextrine function saveState():void {
			if (isInitialized__) {
				flextrine::savedState = new Dictionary(true);
				flextrine::savedState["id"] = id;
				flextrine::savedState["rank"] = rank;
				flextrine::savedState["non_transpondered"] = non_transpondered;
				flextrine::savedState["sub_adults"] = sub_adults;
				flextrine::savedState["pups"] = pups;
				flextrine::savedState["pups_age"] = pups_age;
				flextrine::savedState["pups_male_alive"] = pups_male_alive;
				flextrine::savedState["pups_male_dead"] = pups_male_dead;
				flextrine::savedState["pups_female_alive"] = pups_female_alive;
				flextrine::savedState["pups_female_dead"] = pups_female_dead;
				flextrine::savedState["pups_unknown_alive"] = pups_unknown_alive;
				flextrine::savedState["pups_unknown_dead"] = pups_unknown_dead;
				flextrine::savedState["new_litter"] = new_litter;
				flextrine::savedState["communal"] = communal;
				flextrine::savedState["remark"] = remark;
				mice.flextrine::saveState();
				litters.flextrine::saveState();
				flextrine::savedState["otherLocation"] = otherLocation;
				flextrine::savedState["nestcheck"] = nestcheck;
			}
		}
		
		flextrine function restoreState():void {
			if (isInitialized__) {
				id = flextrine::savedState["id"];
				rank = flextrine::savedState["rank"];
				non_transpondered = flextrine::savedState["non_transpondered"];
				sub_adults = flextrine::savedState["sub_adults"];
				pups = flextrine::savedState["pups"];
				pups_age = flextrine::savedState["pups_age"];
				pups_male_alive = flextrine::savedState["pups_male_alive"];
				pups_male_dead = flextrine::savedState["pups_male_dead"];
				pups_female_alive = flextrine::savedState["pups_female_alive"];
				pups_female_dead = flextrine::savedState["pups_female_dead"];
				pups_unknown_alive = flextrine::savedState["pups_unknown_alive"];
				pups_unknown_dead = flextrine::savedState["pups_unknown_dead"];
				new_litter = (flextrine::savedState["new_litter"] == true);
				communal = (flextrine::savedState["communal"] == true);
				remark = flextrine::savedState["remark"];
				mice.flextrine::restoreState();
				litters.flextrine::restoreState();
				otherLocation = flextrine::savedState["otherLocation"];
				nestcheck = flextrine::savedState["nestcheck"];
			}
		}
		
	}

}
