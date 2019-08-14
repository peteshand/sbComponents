package robotlegs.bender.extensions.component;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.component.model.ComponentDataModel;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.api.IInjector;

class ComponentExtension implements IExtension {
	private var _injector:IInjector;

	public function new() {
		//
	}

	public function extend(context:IContext):Void {
		_injector = context.injector;
		_injector.map(ComponentMap).asSingleton();
		_injector.map(ComponentDataModel).asSingleton();

		var mediatorMap:IMediatorMap = untyped _injector.getInstance(IMediatorMap);
		mediatorMap.map(IComponentView).toMediator(ComponentMediator);

		
	}
}
