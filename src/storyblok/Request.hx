package storyblok;

import haxe.Json;
import haxe.Http;

class Request<T> {
	var http:Http;
	var onComplete:Dynamic;
	var onError:Dynamic;
	var url:String;

	public function new(url:String) {
		this.url = url;
		var q:String = "?";
		if (url.indexOf("?") != -1) {
			q = "&";
		}
		var urlAndQuerystring:String = url + q + "token=" + Storyblok.token + "&per_page=" + 100 + "&cachebuster=" + Math.floor(Math.random() * 10000000);
		trace(urlAndQuerystring);
		http = new Http(urlAndQuerystring);
	}

	public function post(payload:Dynamic, onComplete:T->Void = null, onError:Dynamic = null, expectingJson:Bool = false) {
		request(payload, onComplete, onError, expectingJson, true);
	}

	public function get(payload:Dynamic, onComplete:T->Void = null, onError:Dynamic = null, expectingJson:Bool = false) {
		request(payload, onComplete, onError, expectingJson, false);
	}

	function request(payload:Dynamic, onComplete:T->Void = null, onError:Dynamic = null, expectingJson:Bool = false, post:Bool = false) {
		this.onComplete = onComplete;
		this.onError = onError;

		http.onData = function(data:String) {
			var obj = null;
			try {
				obj = Json.parse(data);
			} catch (e:Dynamic) {
				// if (path != "") trace("can't parse data: " + data);
				if (expectingJson) {
					onError({
						error: "Failed to parse json"
					});
					return;
				}
			}

			onComplete(obj);
		}

		http.onError = function(error:String) {
			var obj = null;
			try {
				obj = Json.parse(error);
			} catch (e:Dynamic) {
				try {
					obj = Json.parse(http.responseData);
				} catch (error:Dynamic) {
					// trace("can't parse data: " + error);
					// trace(http.responseData);
				}
			}
			onError(obj);
		}

		http.onStatus = function(status:Int) {
			// trace('onStatus');
		}

		if (post) {
			if (payload != null) {
				http.setHeader("Content-type", "application/json");
				http.addHeader('accept', 'application/json');
				http.setPostData(Json.stringify(payload));
			}
		}
		http.request(post);
	}
}
