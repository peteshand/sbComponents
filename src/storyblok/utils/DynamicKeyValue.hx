package storyblok.utils;

import robotlegs.bender.extensions.component.ComponentData.UID;
import haxe.Json;

abstract DynamicKeyValue(String) {
	public var component(get, never):String;
	public var _uid(get, never):UID;

	public function new(value:String) {
		this = value;
	}

	@:to
	public function toDynamic():Dynamic {
		var obj:Dynamic = parse();
		if (obj == null)
			return null;
		var data:Dynamic = parse(Reflect.getProperty(obj, "data"));
		if (data != null) {
			Reflect.setProperty(data, "component", Reflect.getProperty(obj, "component"));
			Reflect.setProperty(data, "_uid", Reflect.getProperty(obj, "_uid"));
			return data;
		}

		return obj;
	}

	@:arrayAccess
	public function get(key:String = null):Dynamic {
		var obj:Dynamic = parse();
		if (obj == null || key == "" || key == null)
			return obj;
		return Reflect.getProperty(obj, key);
	}

	function parse(_data:Dynamic = null):Dynamic {
		if (_data == null)
			_data = this;
		if (_data == null)
			return null;
		var obj:Dynamic = null;
		if (Std.is(_data, String)) {
			try {
				return Json.parse(_data);
			} catch (e:Dynamic) {
				trace(e);
				return null;
			}
		}
		return _data;
	}

	function get_component():String {
		return get("component");
	}

	function get__uid():UID {
		return get("_uid");
	}
}
