namespace Planner {
    public class WelcomeView : Granite.Widgets.Welcome {
        public WelcomeView () {
            Object (
                title: _("No Project Open"),
                subtitle: _("Open a project to begin planner.")
            );
        }

        construct {
            valign = Gtk.Align.FILL;
            halign = Gtk.Align.FILL;
            vexpand = true;
            append ("document-new", _("New project"), _("Create a new empty project."));
            append ("document-open", _("Open project"), _("Open a saved project."));

            activated.connect ( (i) => {
                if (i == 0) {
                    // New project
                    //print("New Project");
                }
                else if (i == 1) {
                    // Open Project
                    //print("Open Project");
                }
            });
        }
    }
}
