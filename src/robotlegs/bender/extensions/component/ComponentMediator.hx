package robotlegs.bender.extensions.component;

import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.extensions.component.model.ComponentDataModel;
import fuse.display.Sprite;
import condition.Condition;

/**
 * ...
 * @author P.J.Shand
 */
class ComponentMediator extends Mediator {
	@inject public var view:IComponentView;
	@inject public var componentMap:ComponentMap;
	@inject public var componentDataModel:ComponentDataModel;

	override public function initialize():Void {
		if (view.components != null) {
			view.componentViews = untyped componentMap.createComponents(view.components, view.condition, view.params);
		} else if (view.componentViews == null) {
			view.componentViews = [];
		}

		if (view.componentData != null) {
			componentDataModel.listen(view.componentData._uid, (data:ComponentData) -> {
				view.update(data);
			});
		}
	}
}
