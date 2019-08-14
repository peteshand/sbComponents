package robotlegs.bender.extensions.component;

import condition.Condition;
import fuse.display.Sprite;

interface IComponentView {
	var componentData:ComponentData;
	var components:Array<ComponentData>;
	var componentViews(default, set):Array<Sprite>;
	var condition:Condition;
	var params:Array<Dynamic>;
	function update(componentData:ComponentData):Void;
}
