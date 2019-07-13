package storyblok;

class StoryBlok {
	public static var domain:String = "https://api.storyblok.com/v1/cdn/";

	static var _token:String;
	public static var token(get, set):String;

	static function get_token():String {
		if (StoryBlok._token == null) {
			throw "StoryBlok.token must be set";
		}
		return StoryBlok._token;
	}

	static function set_token(value:String):String {
		return StoryBlok._token = value;
	}

	public static function init(token:String) {
		StoryBlok.token = token;
	}
}
