package storyblok.utils;

abstract SbInt(String) to String {
	public function new(value:String) {
		this = value;
	}

	@:from
	public static function fromString(value:String) {
		return new SbInt(value);
	}

	@:from
	public static function fromInt(value:Int) {
		return new SbInt(Std.string(value));
	}

	@:to
	public function toInt():Int {
		return Std.parseInt(this);
	}

	@:to
	public function toFloat():Float {
		return Std.parseFloat(this);
	}
}
