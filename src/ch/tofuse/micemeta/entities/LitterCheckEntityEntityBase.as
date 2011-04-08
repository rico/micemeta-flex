package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;
	import ch.tofuse.micemeta.entities.NestCheckEntity;
	import ch.tofuse.micemeta.entities.LitterEntity;
	import ch.tofuse.micemeta.entities.OtherLocationEntity;
	import ch.tofuse.micemeta.entities.BoxEntity;

	[Bindable]
	public class LitterCheckEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var savedState:Dictionary;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get remark():String { checkIsInitialized("remark"); return _remark; }
		public function set remark(value:String):void { _remark = value; }
		private var _remark:String;
		
		[Association(side="owning", oppositeAttribute="litterChecks", oppositeCardinality="*")]
		public function get nestcheck():NestCheckEntity { checkIsInitialized("nestcheck"); return _nestcheck; }
		public function set nestcheck(value:NestCheckEntity):void { (value) ? value.flextrine::addValue('litterChecks', this) : ((_nestcheck) ? _nestcheck.flextrine::removeValue('litterChecks', this) : null); _nestcheck = value; }
		private var _nestcheck:NestCheckEntity;
		
		[Association(side="owning", oppositeAttribute="litterChecks", oppositeCardinality="*")]
		public function get litter():LitterEntity { checkIsInitialized("litter"); return _litter; }
		public function set litter(value:LitterEntity):void { (value) ? value.flextrine::addValue('litterChecks', this) : ((_litter) ? _litter.flextrine::removeValue('litterChecks', this) : null); _litter = value; }
		private var _litter:LitterEntity;
		
		[Association(side="owning")]
		public function get otherLocation():OtherLocationEntity { checkIsInitialized("otherLocation"); return _otherLocation; }
		public function set otherLocation(value:OtherLocationEntity):void { _otherLocation = value; }
		private var _otherLocation:OtherLocationEntity;
		
		[Association(side="owning")]
		public function get box():BoxEntity { checkIsInitialized("box"); return _box; }
		public function set box(value:BoxEntity):void { _box = value; }
		private var _box:BoxEntity;
		
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
		
		flextrine function saveState():void {
			if (isInitialized__) {
				flextrine::savedState = new Dictionary(true);
				flextrine::savedState["id"] = id;
				flextrine::savedState["remark"] = remark;
				flextrine::savedState["nestcheck"] = nestcheck;
				flextrine::savedState["litter"] = litter;
				flextrine::savedState["otherLocation"] = otherLocation;
				flextrine::savedState["box"] = box;
			}
		}
		
		flextrine function restoreState():void {
			if (isInitialized__) {
				id = flextrine::savedState["id"];
				remark = flextrine::savedState["remark"];
				nestcheck = flextrine::savedState["nestcheck"];
				litter = flextrine::savedState["litter"];
				otherLocation = flextrine::savedState["otherLocation"];
				box = flextrine::savedState["box"];
			}
		}
		
	}

}
