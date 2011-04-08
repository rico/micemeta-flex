package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;

	[Bindable]
	public class LitterEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var savedState:Dictionary;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get identifier():String { checkIsInitialized("identifier"); return _identifier; }
		public function set identifier(value:String):void { _identifier = value; }
		private var _identifier:String;
		
		public function get first_found_date():Date { checkIsInitialized("first_found_date"); return (_first_found_date && _first_found_date.getTime() > 0) ? _first_found_date : null; }
		public function set first_found_date(value:*):void { _first_found_date = (value is Date) ? value : new Date(value); }
		private var _first_found_date:Date;
		
		public function get first_found_age():int { checkIsInitialized("first_found_age"); return _first_found_age; }
		public function set first_found_age(value:int):void { _first_found_age = value; }
		private var _first_found_age:int;
		
		[Association(side="owning", oppositeAttribute="litters", oppositeCardinality="*")]
		public function get locationChecks():PersistentCollection { checkIsInitialized("locationChecks"); return _locationChecks; }
		public function set locationChecks(value:PersistentCollection):void { _locationChecks = value; }
		private var _locationChecks:PersistentCollection;
		
		[Association(side="inverse", oppositeAttribute="litter", oppositeCardinality="1")]
		public function get litterChecks():PersistentCollection { checkIsInitialized("litterChecks"); return _litterChecks; }
		public function set litterChecks(value:PersistentCollection):void { _litterChecks = value; }
		private var _litterChecks:PersistentCollection;
		
		public function LitterEntityEntityBase() {
			if (!_locationChecks) _locationChecks = new PersistentCollection(null, true, "locationChecks", this);
			if (!_litterChecks) _litterChecks = new PersistentCollection(null, true, "litterChecks", this);
		}
		
		override public function toString():String {
			return "[LitterEntity id=" + id + "]";
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
				flextrine::savedState["identifier"] = identifier;
				flextrine::savedState["first_found_date"] = first_found_date;
				flextrine::savedState["first_found_age"] = first_found_age;
				locationChecks.flextrine::saveState();
				litterChecks.flextrine::saveState();
			}
		}
		
		flextrine function restoreState():void {
			if (isInitialized__) {
				id = flextrine::savedState["id"];
				identifier = flextrine::savedState["identifier"];
				first_found_date = flextrine::savedState["first_found_date"];
				first_found_age = flextrine::savedState["first_found_age"];
				locationChecks.flextrine::restoreState();
				litterChecks.flextrine::restoreState();
			}
		}
		
	}

}
