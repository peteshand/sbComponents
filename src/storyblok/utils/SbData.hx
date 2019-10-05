package storyblok.utils;

import color.Color;

abstract SbData(String) from String {
	public function new(value:String) {
		this = value;
	}

	@:from
	public static function fromString(value:String) {
		// trace("fromString = " + value);
		return new SbData(value);
	}

	@:from
	public static function fromFloat(value:UInt) {
		throw "need to implement";
		return null;
	}

	@:to
	public function toString():String {
		return this;
	}

	@:to
	public function toDate():Date {
		var split1:Array<String> = this.split("T");
		var split2:Array<String> = split1[0].split("-");
		var split3:Array<String> = split1[1].split(":");
		var year:Int = Std.parseInt(split2[0]);
		var month:Int = Std.parseInt(split2[1]);
		var day:Int = Std.parseInt(split2[2]);
		var hour:Int = Std.parseInt(split3[0]);
		var min:Int = Std.parseInt(split3[1]);
		var sec:Int = Std.parseInt(split3[2].split(".")[0]);
		var date:Date = new Date(year, month - 1, day, hour, min, sec);
		return date;
	}
}
