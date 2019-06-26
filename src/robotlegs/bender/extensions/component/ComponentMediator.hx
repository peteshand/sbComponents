package robotlegs.bender.extensions.component;

// import tac.core.definitions.window.AppWindow;
import robotlegs.bender.bundles.mvcs.Mediator;
import fuse.display.Sprite;
import condition.Condition;

/**
 * ...
 * @author P.J.Shand
 */
class ComponentMediator extends Mediator {
	@inject public var view:IComponentView;
	@inject public var componentMap:ComponentMap;

	override public function initialize():Void {
		trace(view);
		if (view.components != null) {
			view.componentViews = createComponents(view.components, view.condition, view.params);
			/*if (componentViews != null) {
				for (componentView in componentViews) {
					view.addChild(componentView);
				}
			}*/
		} else if (view.componentViews == null) {
			view.componentViews = [];
		}
	}

	function createComponents(data:Array<ComponentData>, condition:Condition, params:Array<Dynamic>):Array<Sprite> {
		if (data == null)
			return [];
		var componentViews:Array<Sprite> = [];
		for (i in 0...data.length) {
			var componentData:ComponentData = data[i];
			var componentId:String = componentData.component;
			if (componentData.componentId != null) {
				componentId = componentData.componentId;
			}

			var pass:Bool = true;
			for (test in componentMap.tests) {
				pass = pass && test(componentData);
			}
			if (pass) {
				var itemParams:Array<Dynamic> = [componentData];
				if (condition != null) {
					itemParams.push(condition);
				}
				if (params != null) {
					itemParams = itemParams.concat(params);
				}

				var componentView:Sprite = findComponent(componentId, itemParams);
				if (componentView != null) {
					componentViews.push(componentView);
				}
			}
		}
		return componentViews;
	}

	function findComponent(component:String, params:Array<Dynamic> = null, defaultCompId:String = null):Dynamic {
		var componentType:Class<Dynamic> = componentMap.get(component);
		if (componentType == null) {
			// trace("No component found for: " + component);
			if (defaultCompId == null)
				return null;
			return findComponent(defaultCompId, params);
		}
		if (params == null)
			params = [];
		return Type.createInstance(componentType, params);
	}
}
