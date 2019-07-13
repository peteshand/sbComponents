package storyblok.utils;

abstract SbArray(String) to String {
	public function new(value:String) {
		this = value;
	}

	@:to
	public function toArray():Array<String> {
		var split:Array<String> = this.split(",");
		return untyped split;
	}
}
