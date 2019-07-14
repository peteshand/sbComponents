package storyblok.utils;

import color.Color;

abstract SbColor(String) from String {
	public function new(value:String) {
		this = value;
	}

	@:from
	public static function fromString(value:String) {
		// trace("fromString = " + value);
		return new SbColor(value);
	}

	@:from
	public static function fromInt(value:UInt) {
		// trace("fromInt = " + value);
		var s:String = "0x" + Std.string(StringTools.hex(value, 8));
		return new SbColor(s);
	}

	@:from
	public static function fromSbColor(value:SbColor) {
		// trace("fromSbColor = " + fromSbColor);
		var s:Color = value;
		return SbColor.fromInt(s);
	}

	@:to
	public function toString():String {
		// trace("toString");
		return "0x" + StringTools.hex(toColor(), 8);
	}

	@:to
	public function toColor():Color {
		// trace("toColor");
		if (this == null)
			return 0x0;

		var hex:String = "0x0";
		var color:Color = 0;
		if (Std.is(this, String)) {
			if (this.indexOf("#") == 0)
				hex = "0x" + this.substring(1, this.length);
			else if (this.indexOf("0x") == 0)
				hex = this;
			color = Std.parseInt(hex);
		}

		var subColor:String = Reflect.getProperty(this, "color");
		if (subColor != null) {
			color = subColor;
			color.alpha = 0xFF;
		}

		return color;
	}

	public function isNull():Bool {
		if (this == null)
			return true;
		if (Std.is(this, String)) {
			if (this == "")
				return true;
			else
				return false;
		} else {
			var subColor:String = Reflect.getProperty(this, "color");
			if (subColor != null) {
				if (subColor == "")
					return true;
				else
					return false;
			}
			return false;
		}
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
