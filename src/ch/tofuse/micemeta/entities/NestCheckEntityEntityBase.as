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
		public function get locationChecks():PersistentCollection { checkIsInitialized("locationChecks"); return _locationChecks; }
		public function set locationChecks(value:PersistentCollection):void { _locationChecks = value; }
		private var _locationChecks:PersistentCollection;
		
		public function NestCheckEntityEntityBase() {
			if (!_locationChecks) _locationChecks = new PersistentCollection(null, true, "locationChecks", this);
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
		
		flextrine function saveState():Dictionary {
			if (isInitialized__) {
				var memento:Dictionary = new Dictionary(true);
				memento["id"] = id;
				memento["checkdate"] = checkdate;
				memento["user"] = user;
				memento["locationChecks"] = locationChecks.flextrine::saveState();
				return memento;
			}
			
			return null;
		}
		
		flextrine function restoreState(memento:Dictionary):void {
			if (isInitialized__) {
				id = memento["id"];
				checkdate = memento["checkdate"];
				user = memento["user"];
				locationChecks.flextrine::restoreState(memento["locationChecks"]);
			}
		}
		
	}

}
