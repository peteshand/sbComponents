package robotlegs.bender.extensions.component;

import fuse.display.Quad;
import fuse.display.Sprite;
import condition.Condition;

class ComponentView extends Sprite implements IComponentView {
	public var componentData:ComponentData;
	public var components:Array<ComponentData>;
	@:isVar public var componentViews(default, set):Array<Sprite> = [];
	public var condition:Condition;
	public var params:Array<Dynamic>;
	

	public function new(?componentData:ComponentData, ?components:Array<ComponentData>, ?condition:Condition, ?params:Array<Dynamic>) {
		super();
		this.componentData = untyped componentData;
		this.components = components;
		this.condition = condition;
		this.params = params;
	}

	public function initialize() {}

	function set_componentViews(value:Array<Sprite>):Array<Sprite>
	{
		componentViews = value;
		if (componentViews != null){
			for (componentView in componentViews) {
				addChild(componentView);
			}
		}
		return componentViews;
	}
}
