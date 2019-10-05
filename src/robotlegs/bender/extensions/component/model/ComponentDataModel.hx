package robotlegs.bender.extensions.component.model;

import robotlegs.bender.extensions.component.ComponentData;
import notifier.Notifier;

class ComponentDataModel {
	var data = new Map<UID, LangData>();

	@:isVar public var currentLangauge(default, set):String = "default";

	public function new() {
		//
	}

	public function set(lang:String = "default", componentData:ComponentData) {
		var langData:LangData = get(componentData._uid);
		langData.set(lang, componentData);
		langData.currentLangauge = currentLangauge;
	}

	function get(uid:String):LangData {
		var langData:LangData = data.get(uid);
		if (langData == null) {
			langData = new LangData(uid);
			data.set(uid, langData);
		}
		return langData;
	}

	public function listen(uid:String, callback:ComponentData->Void) {
		get(uid).current.add(callback).fireOnAdd();
	}

	function set_currentLangauge(value:String):String {
		currentLangauge = value;
		for (item in data.iterator()) {
			item.currentLangauge = currentLangauge;
		}
		return currentLangauge;
	}
}

class LangData {
	var _uid:String;
	var data = new Map<String, ComponentData>();

	public var current = new Notifier<ComponentData>();
	public var currentLangauge(default, set):String;

	public function new(_uid:String) {
		this._uid = _uid;
	}

	public function set(lang:String, componentData:ComponentData) {
		data.set(lang, componentData);
	}

	public function get(uid:String):ComponentData {
		return data.get(uid);
	}

	function set_currentLangauge(value:String):String {
		current.value = data.get(value);
		return currentLangauge = value;
	}
}

typedef UID = String;
/*

	var simulateClick = function (elem) {
	// Create our event (with options)
	var evt = new MouseEvent('click', {
		bubbles: true,
		cancelable: true,
		view: window
	});
	// If cancelled, don't dispatch our event
	var canceled = !elem.dispatchEvent(evt);
	};
	var stopCover = document.getElementById('stopCover')
	setInterval(() => {
	if (stopCover.style.display == "block"){
		simulateClick(document.body)
	}
	}, 1)

 */
