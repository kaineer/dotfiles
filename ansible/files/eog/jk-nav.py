from gi.repository import GObject, Eog


class JkNavPlugin(GObject.Object, Eog.WindowActivatable):
    window = GObject.property(type=Eog.Window)

    actions = (
        ("win.go-next", "j"),
        ("win.go-previous", "k"),
        ("win.go-first", "g"),
        ("win.go-last", "<Shift>g"),
    )

    def do_activate(self):
        app = Eog.Application.get_instance()
        for action, key in self.actions:
            accels = list(app.get_accels_for_action(action))
            if key not in accels:
                accels.append(key)
            app.set_accels_for_action(action, accels)

    def do_deactivate(self):
        pass
