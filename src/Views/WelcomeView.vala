namespace Planner {
    public class WelcomeView : Granite.Widgets.Welcome {

        public signal void on_welcome_select (int index);

        public WelcomeView () {

            Object (
                title: _("Planner"),
                subtitle: _("Project management, as effective as it gets")
            );
        }

        construct {
            
            valign = Gtk.Align.FILL;
            halign = Gtk.Align.FILL;
            vexpand = true;
            append ("project-new", _("New project"), _("Create a new empty project"));
            append ("document-open", _("Open project"), _("Open a saved project"));

            activated.connect ( (i) => {
                if (i == 0) {
                    // Create New Project
                    on_welcome_select (0);

                } else if (i == 1) {
                    // Open Project
                }
            });
        }
    }
}
