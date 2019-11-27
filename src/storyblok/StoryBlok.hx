package storyblok;

import js.lib.Promise;
import signals.Signal;
import notifier.Notifier;
import notifier.utils.Persist;

class Storyblok {
	public static var domain:String = "https://api.storyblok.com/v1/";

	static var pollFrequency:Int;
	static var _token:String;
	static var version = new Notifier<Float>(0);
	static var status:Request<StatusData>;

	public static var token(get, set):String;
	public static var newContentAvailable = new Signal();

	static function get_token():String {
		if (Storyblok._token == null) {
			throw "Storyblok.token must be set";
		}
		return Storyblok._token;
	}

	static function set_token(value:String):String {
		return Storyblok._token = value;
	}

	public static function init(token:String, pollFrequency:Int = 60000) {
		Storyblok.token = token;
		Storyblok.pollFrequency = pollFrequency;

		status = new Request<StatusData>(domain + "cdn/spaces/me");
		version.add(onVersionChange);
		Persist.register(version, "StoryblokVersion");
		checkForChanges();
	}

	static function onVersionChange(version:Float) {
		newContentAvailable.dispatch();
	}

	static function checkForChanges() {
		if (Storyblok.pollFrequency != -1) {
			haxe.Timer.delay(checkForChanges, Storyblok.pollFrequency);
		}
		status.get(null, (value : StatusData) -> {
			// trace(value);
			version.value = value.space.version;
		}, (error) -> {
				trace(error);
			});
	}

	public static function get(path:String, filters:Dynamic = null) {
		if (filters != null) {
			throw 'need to implement filters';
		}
		// trace("url = " + domain + path);
		var promise = new Promise(function(resolve, reject) {
			var request = new Request<Dynamic>(domain + path);
			request.get(null, resolve, reject);
		});

		return promise;
	}
}

typedef StatusData = {
	space:{
		id:Int, name:String, domain:String, version:Float, language_codes:Array<String>
	}
}
