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
		if (view.components != null) {
			view.componentViews = untyped componentMap.createComponents(view.components, view.condition, view.params);
		} else if (view.componentViews == null) {
			view.componentViews = [];
		}
	}
}
