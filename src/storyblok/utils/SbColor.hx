package storyblok.utils;

import color.Color;

abstract SbColor(String) from String {
	public function new(value:String) {
		this = value;
	}

	@:from
	public static function fromString(value:String) {
		return new SbColor(value);
	}

	@:from
	public static function fromInt(value:Int) {
		var s:String = "0x" + Std.string(StringTools.hex(value, 8));
		return new SbColor(s);
	}

	@:to
	public function toColor():Color {
		if (this == null)
			return 0x0;

		var hex:String = "0x0";
		if (this.indexOf("#") == 0)
			hex = "0x" + this.substring(1, this.length);
		else if (this.indexOf("0x") == 0)
			hex = this;
		var color:Color = Std.parseInt(hex);
		return color;
	}
}
/*
	abstract SbColor(String) to String {
	public function new(value:String) {
		if (value == null)
			this = null;
		else if (value.indexOf("#") == 0) {
			this = "0x" + value.substr(1, value.length - 1);
		} else if (value.indexOf("0x") == 0) {
			this = value;
		} else if (value == null) {
			this = "0x00000000";
		} else {
			this = "0xFFFFFFFF";
		}
	}

	@:from
	public static function fromSBColor(value:SbColor) {
		return new SbColor(value);
	}

	@:to
	public function toColor():Null<Color> {
		if (this == null)
			return null;
		return Std.parseInt(this);
	}
	}
 */
