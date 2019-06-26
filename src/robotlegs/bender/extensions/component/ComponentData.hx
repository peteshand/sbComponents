package robotlegs.bender.extensions.component;

typedef ComponentData = {
	?_uid:UID,
	?component:String,
	// override 'component'
	?componentId:String,
	?conditionId:String,
	?components:Array<ComponentData>,
	?enabled:Null<Bool>
}

abstract UID(String) from String to String {
	public inline function new(s:String)
		this = s;
}
