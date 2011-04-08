package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;
	import ch.tofuse.micemeta.entities.UserEntity;

	[Bindable]
	public class NestCheckEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var savedState:Dictionary;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get checkdate():Date { checkIsInitialized("checkdate"); return (_checkdate && _checkdate.getTime() > 0) ? _checkdate : null; }
		public function set checkdate(value:*):void { _checkdate = (value is Date) ? value : new Date(value); }
		private var _checkdate:Date;
		
		[Association(side="owning")]
		public function get user():UserEntity { checkIsInitialized("user"); return _user; }
		public function set user(value:UserEntity):void { _user = value; }
		private var _user:UserEntity;
		
		[Association(side="inverse", oppositeAttribute="nestcheck", oppositeCardinality="1")]
		public function get box_checks():PersistentCollection { checkIsInitialized("box_checks"); return _box_checks; }
		public function set box_checks(value:PersistentCollection):void { _box_checks = value; }
		private var _box_checks:PersistentCollection;
		
		[Association(side="inverse", oppositeAttribute="nestcheck", oppositeCardinality="1")]
		public function get litterChecks():PersistentCollection { checkIsInitialized("litterChecks"); return _litterChecks; }
		public function set litterChecks(value:PersistentCollection):void { _litterChecks = value; }
		private var _litterChecks:PersistentCollection;
		
		[Association(side="inverse", oppositeAttribute="nestcheck", oppositeCardinality="1")]
		public function get other_location_checks():PersistentCollection { checkIsInitialized("other_location_checks"); return _other_location_checks; }
		public function set other_location_checks(value:PersistentCollection):void { _other_location_checks = value; }
		private var _other_location_checks:PersistentCollection;
		
		public function NestCheckEntityEntityBase() {
			if (!_box_checks) _box_checks = new PersistentCollection(null, true, "box_checks", this);
			if (!_litterChecks) _litterChecks = new PersistentCollection(null, true, "litterChecks", this);
			if (!_other_location_checks) _other_location_checks = new PersistentCollection(null, true, "other_location_checks", this);
		}
		
		override public function toString():String {
			return "[NestCheckEntity id=" + id + "]";
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
				flextrine::savedState["checkdate"] = checkdate;
				flextrine::savedState["user"] = user;
				box_checks.flextrine::saveState();
				litterChecks.flextrine::saveState();
				other_location_checks.flextrine::saveState();
			}
		}
		
		flextrine function restoreState():void {
			if (isInitialized__) {
				id = flextrine::savedState["id"];
				checkdate = flextrine::savedState["checkdate"];
				user = flextrine::savedState["user"];
				box_checks.flextrine::restoreState();
				litterChecks.flextrine::restoreState();
				other_location_checks.flextrine::restoreState();
			}
		}
		
	}

}
