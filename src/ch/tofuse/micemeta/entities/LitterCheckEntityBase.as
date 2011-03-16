package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;
  	import ch.tofuse.micemeta.entities.Litter;
   	import ch.tofuse.micemeta.entities.OtherLocation;
   	import ch.tofuse.micemeta.entities.Box;
  
	[Bindable]
	public class LitterCheckEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var savedState:Dictionary;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get checkdate():Date { checkIsInitialized("checkdate"); return (_checkdate && _checkdate.getTime() > 0) ? _checkdate : null; }
		public function set checkdate(value:*):void { _checkdate = (value is Date) ? value : new Date(value); }
		private var _checkdate:Date;
		
		public function get remark():String { checkIsInitialized("remark"); return _remark; }
		public function set remark(value:String):void { _remark = value; }
		private var _remark:String;
		
		[Association(side="owning", oppositeAttribute="litterChecks", oppositeCardinality="*")]
		public function get litter():Litter { checkIsInitialized("litter"); return _litter; }
		public function set litter(value:Litter):void { (value) ? value.flextrine::addValue('litterChecks', this) : ((_litter) ? _litter.flextrine::removeValue('litterChecks', this) : null); _litter = value; }
		private var _litter:Litter;
		
		[Association(side="owning")]
		public function get otherLocation():OtherLocation { checkIsInitialized("otherLocation"); return _otherLocation; }
		public function set otherLocation(value:OtherLocation):void { _otherLocation = value; }
		private var _otherLocation:OtherLocation;
		
		[Association(side="owning")]
		public function get box():Box { checkIsInitialized("box"); return _box; }
		public function set box(value:Box):void { _box = value; }
		private var _box:Box;
		
		public function LitterCheckEntityBase() {
		}
		
		override public function toString():String {
			return "[LitterCheck id=" + id + "]";
		}
		
		private function checkIsInitialized(property:String):void {
			if (!isInitialized__ && isUnserialized__)
				dispatchEvent(new EntityEvent(EntityEvent.INITIALIZE_ENTITY, property));
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
				flextrine::savedState["checkdate"] = checkdate;
				flextrine::savedState["remark"] = remark;
				flextrine::savedState["litter"] = litter;
				flextrine::savedState["otherLocation"] = otherLocation;
				flextrine::savedState["box"] = box;
			}
		}
		
		flextrine function restoreState():void {
			if (isInitialized__) {
				id = flextrine::savedState["id"];
				checkdate = flextrine::savedState["checkdate"];
				remark = flextrine::savedState["remark"];
				litter = flextrine::savedState["litter"];
				otherLocation = flextrine::savedState["otherLocation"];
				box = flextrine::savedState["box"];
			}
		}
		
	}

}
