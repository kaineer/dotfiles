// Toggle the Changes side panel. Invoke with mod.open:changes-toggle.
import { View, div } from "gpui-kit";
import { layout, run, props, closeOverlay } from "herdr";

const CHILD = "changes";

function find(node, id) {
  if (node?.id === id) return node;
  for (const child of node?.children ?? []) {
    const found = find(child, id);
    if (found) return found;
  }
  return null;
}

export default class ChangesToggle extends View {
  init(_props, cx) {
    const panel = find(layout(), "panel");
    const body = find(layout(), "panel-body");
    const on = panel && !panel.hidden && body?.active === CHILD;
    if (on) run("layout.hide", { id: "panel" });
    else {
      run("layout.select", { stack: "panel-body", child: CHILD });
      run("layout.show", { id: "panel" });
    }
    cx.timer.after(0, () => closeOverlay(props()?.overlay));
  }

  render() {
    return div().w(1).h(1);
  }
}
