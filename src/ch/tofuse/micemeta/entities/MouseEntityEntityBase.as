package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;

	[Bindable]
	public class MouseEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get rfid():String { checkIsInitialized("rfid"); return _rfid; }
		public function set rfid(value:String):void { _rfid = value; }
		private var _rfid:String;
		
		public function get birth_date():Date { checkIsInitialized("birth_date"); return (_birth_date && _birth_date.getTime() > 0) ? _birth_date : null; }
		public function set birth_date(value:*):void { _birth_date = (value is Date) ? value : new Date(value); }
		private var _birth_date:Date;
		
		public function get death_date():Date { checkIsInitialized("death_date"); return (_death_date && _death_date.getTime() > 0) ? _death_date : null; }
		public function set death_date(value:*):void { _death_date = (value is Date) ? value : new Date(value); }
		private var _death_date:Date;
		
		public function get import_date():Date { checkIsInitialized("import_date"); return (_import_date && _import_date.getTime() > 0) ? _import_date : null; }
		public function set import_date(value:*):void { _import_date = (value is Date) ? value : new Date(value); }
		private var _import_date:Date;
		
		public function get dir():Date { checkIsInitialized("dir"); return (_dir && _dir.getTime() > 0) ? _dir : null; }
		public function set dir(value:*):void { _dir = (value is Date) ? value : new Date(value); }
		private var _dir:Date;
		
		public function get res():Date { checkIsInitialized("res"); return (_res && _res.getTime() > 0) ? _res : null; }
		public function set res(value:*):void { _res = (value is Date) ? value : new Date(value); }
		private var _res:Date;
		
		public function get i():int { checkIsInitialized("i"); return _i; }
		public function set i(value:int):void { _i = value; }
		private var _i:int;
		
		public function get data_count():int { checkIsInitialized("data_count"); return _data_count; }
		public function set data_count(value:int):void { _data_count = value; }
		private var _data_count:int;
		
		public function get dir_count():int { checkIsInitialized("dir_count"); return _dir_count; }
		public function set dir_count(value:int):void { _dir_count = value; }
		private var _dir_count:int;
		
		public function get res_count():int { checkIsInitialized("res_count"); return _res_count; }
		public function set res_count(value:int):void { _res_count = value; }
		private var _res_count:int;
		
		public function get sex():String { checkIsInitialized("sex"); return _sex; }
		public function set sex(value:String):void { _sex = value; }
		private var _sex:String;
		
		public function get last():Date { checkIsInitialized("last"); return (_last && _last.getTime() > 0) ? _last : null; }
		public function set last(value:*):void { _last = (value is Date) ? value : new Date(value); }
		private var _last:Date;
		
		public function get implant_date():Date { checkIsInitialized("implant_date"); return (_implant_date && _implant_date.getTime() > 0) ? _implant_date : null; }
		public function set implant_date(value:*):void { _implant_date = (value is Date) ? value : new Date(value); }
		private var _implant_date:Date;
		
		public function get weight():Number { checkIsInitialized("weight"); return _weight; }
		public function set weight(value:Number):void { _weight = value; }
		private var _weight:Number = 0;
		
		[Association(side="inverse", oppositeAttribute="mice", oppositeCardinality="*")]
		public function get boxChecks():PersistentCollection { checkIsInitialized("boxChecks"); return _boxChecks; }
		public function set boxChecks(value:PersistentCollection):void { _boxChecks = value; }
		private var _boxChecks:PersistentCollection;
		
		[Association(side="inverse", oppositeAttribute="mice", oppositeCardinality="*")]
		public function get otherLocationChecks():PersistentCollection { checkIsInitialized("otherLocationChecks"); return _otherLocationChecks; }
		public function set otherLocationChecks(value:PersistentCollection):void { _otherLocationChecks = value; }
		private var _otherLocationChecks:PersistentCollection;
		
		[Association(side="inverse", oppositeAttribute="mice", oppositeCardinality="*")]
		public function get locationChecks():PersistentCollection { checkIsInitialized("locationChecks"); return _locationChecks; }
		public function set locationChecks(value:PersistentCollection):void { _locationChecks = value; }
		private var _locationChecks:PersistentCollection;
		
		public function MouseEntityEntityBase() {
			if (!_boxChecks) _boxChecks = new PersistentCollection(null, true, "boxChecks", this);
			if (!_otherLocationChecks) _otherLocationChecks = new PersistentCollection(null, true, "otherLocationChecks", this);
			if (!_locationChecks) _locationChecks = new PersistentCollection(null, true, "locationChecks", this);
		}
		
		override public function toString():String {
			return "[MouseEntity id=" + id + "]";
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
		
		flextrine function saveState():Dictionary {
			if (isInitialized__) {
				var memento:Dictionary = new Dictionary(true);
				memento["id"] = id;
				memento["rfid"] = rfid;
				memento["birth_date"] = birth_date;
				memento["death_date"] = death_date;
				memento["import_date"] = import_date;
				memento["dir"] = dir;
				memento["res"] = res;
				memento["i"] = i;
				memento["data_count"] = data_count;
				memento["dir_count"] = dir_count;
				memento["res_count"] = res_count;
				memento["sex"] = sex;
				memento["last"] = last;
				memento["implant_date"] = implant_date;
				memento["weight"] = weight;
				memento["boxChecks"] = boxChecks.flextrine::saveState();
				memento["otherLocationChecks"] = otherLocationChecks.flextrine::saveState();
				memento["locationChecks"] = locationChecks.flextrine::saveState();
				return memento;
			}
			
			return null;
		}
		
		flextrine function restoreState(memento:Dictionary):void {
			if (isInitialized__) {
				id = memento["id"];
				rfid = memento["rfid"];
				birth_date = memento["birth_date"];
				death_date = memento["death_date"];
				import_date = memento["import_date"];
				dir = memento["dir"];
				res = memento["res"];
				i = memento["i"];
				data_count = memento["data_count"];
				dir_count = memento["dir_count"];
				res_count = memento["res_count"];
				sex = memento["sex"];
				last = memento["last"];
				implant_date = memento["implant_date"];
				weight = memento["weight"];
				boxChecks.flextrine::restoreState(memento["boxChecks"]);
				otherLocationChecks.flextrine::restoreState(memento["otherLocationChecks"]);
				locationChecks.flextrine::restoreState(memento["locationChecks"]);
			}
		}
		
	}

}
