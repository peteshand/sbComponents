package robotlegs.bender.extensions.component;

import org.swiftsuspenders.utils.DescribedType;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatorMap.impl.MediatorMap;
import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
import condition.Condition;

class ComponentMap implements DescribedType {
	static var classes = new Map<String, Class<Dynamic>>();
	static var components = new Map<String, IMediatorMapper>();
	static var _context:IContext;

	@inject public var context:IContext;
	@inject public var mediatorMap:IMediatorMap;

	public var tests:Array<(componentData:Dynamic) -> Bool> = [];

	var componentName:String;

	public function name(componentName:String) {
		if (_context == null) {
			_context = context;
		}
		this.componentName = componentName;
		return this;
	}

	public function map(type:Class<Dynamic>):IMediatorMapper {
		if (componentName == null)
			return null;
		// trace("map: " + componentName);
		classes.set(componentName, type);
		var mediatorMapper:IMediatorMapper = components.get(componentName);
		if (mediatorMapper == null) {
			mediatorMapper = mediatorMap.map(type);
			components.set(componentName, mediatorMapper);
		}
		componentName = null;
		return mediatorMapper;
	}

	public function get(componentName:String):Class<Dynamic> {
		return classes.get(componentName);
	}

	public function addTest(test:(componentData:Dynamic) -> Bool) {
		tests.push(test);
	}

	public function createComponents(data:Array<ComponentData>, condition:Condition, params:Array<Dynamic>):Array<Dynamic> {
		if (data == null)
			return [];
		var componentViews:Array<Dynamic> = [];
		for (i in 0...data.length) {
			var componentData:ComponentData = data[i];
			var componentId:String = componentData.component;

			if (componentData.componentId != null) {
				componentId = componentData.componentId;
			}

			var pass:Bool = true;
			for (test in tests) {
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

				var componentView = findComponent(componentId, itemParams);
				if (componentView != null) {
					componentViews.push(componentView);
				}
			}
		}
		return componentViews;
	}

	function findComponent(component:String, params:Array<Dynamic> = null, defaultCompId:String = null):Dynamic {
		var componentType:Class<Dynamic> = get(component);
		if (componentType == null) {
			// trace("No component found for: " + component);
			if (defaultCompId == null)
				return null;
			return findComponent(defaultCompId, params);
		}
		if (params == null)
			params = [];
		// trace(params);
		return Type.createInstance(componentType, params);
	}
}
