package storyblok.utils;

#if electron
import storyblok.cacher.SbCacher;
#end
import storyblok.StoryBlok;

abstract SbAsset(String) {
	public function new(value:String) {
		this = value;
	}

	@:to
	public function toString():String {
		#if electron
		if (this == null || this == "")
			return null;
		var url:String = SbCacher.cache("https:" + this + "?token=" + StoryBlok.token);
		return url;
		#else
		// trace(this);
		// trace(this.indexOf("./"));
		if (this.indexOf("./") == 0)
			return this;
		else
			return "https:" + this + "?token=" + StoryBlok.token;
		#end
	}
}
