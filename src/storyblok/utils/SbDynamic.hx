package storyblok.utils;

import haxe.Json;

abstract SbDynamic(String) from String {
	public function new(value:String) {
		this = value;
	}

	@:to
	public function toDynamic():Dynamic {
		try {
			var value:Dynamic = Json.parse(this);
			return value;
		} catch (e:Dynamic) {
			trace("Error: " + e);
		}
		return this;
	}
}
