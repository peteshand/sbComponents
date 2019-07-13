package storyblok.utils;

@:forward(length)
abstract FirstElement(Array<DynamicKeyValue>) {
	public function new(value:Array<DynamicKeyValue>) {
		this = value;
	}

	@:to
	public function toFirstElement():Dynamic {
		if (Std.is(this, Array)) {
			if (this.length == 0)
				return null;
			return this[0];
		}
		return this;
	}

	@:from
	public static function fromDynamic(value:Dynamic):FirstElement {
		if (Std.is(value, Array))
			return new FirstElement(value);
		return new FirstElement([value]);
	}
}
