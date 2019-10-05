package storyblok.types;

abstract UID(String) from String to String {
	public inline function new(s:String)
		this = s;
}
