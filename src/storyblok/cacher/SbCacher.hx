package storyblok.cacher;

#if electron
import mantle.net.LocalFileCheckUtil;
import mantle.net.FileCacher;
import openfl.filesystem.File;
#end

class SbCacher {
	static var map = new Map<String, String>();

	public static function cache(remoteUrl:String):String {
		var local:String = map.get(remoteUrl);
		#if electron
		if (local == null) {
			local = LocalFileCheckUtil.localPath(remoteUrl);
			if (!exists(local)) {
				// File yet to be cached
				// fall back to remote url
				local = remoteUrl;
				// Download file for future load
				var fileCacher:FileCacher = new FileCacher(remoteUrl);
			}
			map.set(remoteUrl, local);
		}
		#end
		return local;
	}

	#if electron
	static function exists(filePath:String) {
		var file = new File(filePath);
		return file.exists;
	}
	#end
}
