package robotlegs.bender.extensions.component;

import org.swiftsuspenders.utils.DescribedType;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatorMap.impl.MediatorMap;
import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;

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
}
