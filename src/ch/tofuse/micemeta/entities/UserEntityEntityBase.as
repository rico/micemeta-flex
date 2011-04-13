package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;
	import ch.tofuse.micemeta.entities.UserGroupEntity;

	[Bindable]
	public class UserEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get fname():String { checkIsInitialized("fname"); return _fname; }
		public function set fname(value:String):void { _fname = value; }
		private var _fname:String;
		
		public function get lname():String { checkIsInitialized("lname"); return _lname; }
		public function set lname(value:String):void { _lname = value; }
		private var _lname:String;
		
		public function get acronym():String { checkIsInitialized("acronym"); return _acronym; }
		public function set acronym(value:String):void { _acronym = value; }
		private var _acronym:String;
		
		[Association(side="owning", oppositeAttribute="users", oppositeCardinality="*")]
		public function get userGroup():UserGroupEntity { checkIsInitialized("userGroup"); return _userGroup; }
		public function set userGroup(value:UserGroupEntity):void { (value) ? value.flextrine::addValue('users', this) : ((_userGroup) ? _userGroup.flextrine::removeValue('users', this) : null); _userGroup = value; }
		private var _userGroup:UserGroupEntity;
		
		public function UserEntityEntityBase() {
		}
		
		override public function toString():String {
			return "[UserEntity id=" + id + "]";
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
				memento["fname"] = fname;
				memento["lname"] = lname;
				memento["acronym"] = acronym;
				memento["userGroup"] = userGroup;
				return memento;
			}
			
			return null;
		}
		
		flextrine function restoreState(memento:Dictionary):void {
			if (isInitialized__) {
				id = memento["id"];
				fname = memento["fname"];
				lname = memento["lname"];
				acronym = memento["acronym"];
				userGroup = memento["userGroup"];
			}
		}
		
	}

}
