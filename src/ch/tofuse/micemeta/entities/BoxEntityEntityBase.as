package ch.tofuse.micemeta.entities {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.events.PropertyChangeEvent;
	import mx.collections.errors.ItemPendingError;
	import org.davekeen.flextrine.orm.collections.PersistentCollection;
	import org.davekeen.flextrine.orm.events.EntityEvent;
	import org.davekeen.flextrine.flextrine;

	[Bindable]
	public class BoxEntityEntityBase extends EventDispatcher {
		
		public var isUnserialized__:Boolean;
		
		public var isInitialized__:Boolean = true;
		
		flextrine var savedState:Dictionary;
		
		flextrine var itemPendingError:ItemPendingError;
		
		[Id]
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		private var _id:String;
		
		public function get segment():String { checkIsInitialized("segment"); return _segment; }
		public function set segment(value:String):void { _segment = value; }
		private var _segment:String;
		
		public function get last():Date { checkIsInitialized("last"); return (_last && _last.getTime() > 0) ? _last : null; }
		public function set last(value:*):void { _last = (value is Date) ? value : new Date(value); }
		private var _last:Date;
		
		public function get data_count():int { checkIsInitialized("data_count"); return _data_count; }
		public function set data_count(value:int):void { _data_count = value; }
		private var _data_count:int;
		
		public function get dir_count():int { checkIsInitialized("dir_count"); return _dir_count; }
		public function set dir_count(value:int):void { _dir_count = value; }
		private var _dir_count:int;
		
		public function get res_count():int { checkIsInitialized("res_count"); return _res_count; }
		public function set res_count(value:int):void { _res_count = value; }
		private var _res_count:int;
		
		public function get xcoord():int { checkIsInitialized("xcoord"); return _xcoord; }
		public function set xcoord(value:int):void { _xcoord = value; }
		private var _xcoord:int;
		
		public function get ycoord():int { checkIsInitialized("ycoord"); return _ycoord; }
		public function set ycoord(value:int):void { _ycoord = value; }
		private var _ycoord:int;
		
		[Association(side="inverse", oppositeAttribute="box", oppositeCardinality="1")]
		public function get box_checks():PersistentCollection { checkIsInitialized("box_checks"); return _box_checks; }
		public function set box_checks(value:PersistentCollection):void { _box_checks = value; }
		private var _box_checks:PersistentCollection;
		
		public function BoxEntityEntityBase() {
			if (!_box_checks) _box_checks = new PersistentCollection(null, true, "box_checks", this);
		}
		
		override public function toString():String {
			return "[BoxEntity id=" + id + "]";
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
				flextrine::savedState["segment"] = segment;
				flextrine::savedState["last"] = last;
				flextrine::savedState["data_count"] = data_count;
				flextrine::savedState["dir_count"] = dir_count;
				flextrine::savedState["res_count"] = res_count;
				flextrine::savedState["xcoord"] = xcoord;
				flextrine::savedState["ycoord"] = ycoord;
				box_checks.flextrine::saveState();
			}
		}
		
		flextrine function restoreState():void {
			if (isInitialized__) {
				id = flextrine::savedState["id"];
				segment = flextrine::savedState["segment"];
				last = flextrine::savedState["last"];
				data_count = flextrine::savedState["data_count"];
				dir_count = flextrine::savedState["dir_count"];
				res_count = flextrine::savedState["res_count"];
				xcoord = flextrine::savedState["xcoord"];
				ycoord = flextrine::savedState["ycoord"];
				box_checks.flextrine::restoreState();
			}
		}
		
	}

}
