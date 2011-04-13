package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;
	import ch.tofuse.micemeta.entities.ILocationCheck;
	import ch.tofuse.micemeta.entities.LitterEntity;

	[Bindable]
	public class LitterCheckEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get remark():String { checkIsInitialized("remark"); return _remark; }
		public function set remark(value:String):void { _remark = value; }
		private var _remark:String;
		
		[Association(side="owning", oppositeAttribute="litterChecks", oppositeCardinality="*")]
		public function get locationCheck():ILocationCheck { checkIsInitialized("locationCheck"); return _locationCheck; }
		public function set locationCheck(value:ILocationCheck):void { (value) ? value.flextrine::addValue('litterChecks', this) : ((_locationCheck) ? _locationCheck.flextrine::removeValue('litterChecks', this) : null); _locationCheck = value; }
		private var _locationCheck:ILocationCheck;
		
		[Association(side="owning", oppositeAttribute="litterChecks", oppositeCardinality="*")]
		public function get litter():LitterEntity { checkIsInitialized("litter"); return _litter; }
		public function set litter(value:LitterEntity):void { (value) ? value.flextrine::addValue('litterChecks', this) : ((_litter) ? _litter.flextrine::removeValue('litterChecks', this) : null); _litter = value; }
		private var _litter:LitterEntity;
		
		public function LitterCheckEntityEntityBase() {
		}
		
		override public function toString():String {
			return "[LitterCheckEntity id=" + id + "]";
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
				memento["remark"] = remark;
				memento["locationCheck"] = locationCheck;
				memento["litter"] = litter;
				return memento;
			}
			
			return null;
		}
		
		flextrine function restoreState(memento:Dictionary):void {
			if (isInitialized__) {
				id = memento["id"];
				remark = memento["remark"];
				locationCheck = memento["locationCheck"];
				litter = memento["litter"];
			}
		}
		
	}

}
