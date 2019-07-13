package storyblok.utils;

abstract SbFloat(String) to String {
	public function new(value:String) {
		this = value;
	}

	@:from
	public static function fromString(value:String) {
		return new SbFloat(value);
	}

	@:from
	public static function fromFloat(value:Float) {
		return new SbFloat(Std.string(value));
	}

	@:to
	public function toFloat():Float {
		return Std.parseFloat(this);
	}
}
