// Kept in the layout as a no-op placeholder. Pane/split Alt+hjkl is handled by:
// - keys.json terminal passthrough of alt-hjkl into the program
// - neovim multiplexor-nav maps (wincmd, then herdr-app pane.go on edge)
// - keys.json global alt-hjkl → pane.go when focus is not in a terminal
import { View, div } from "gpui-kit";

export default class VimNav extends View {
  render() {
    return div().id("vim-nav").w(1).h(1);
  }
}
