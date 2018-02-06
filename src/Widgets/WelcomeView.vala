namespace Planner {
    public class WelcomeView : Granite.Widgets.Welcome {

        public SqliteDatabase db;
        
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
                    Utils.create_dir_with_parents ("/.local/share/planner/");
                    this.db = new SqliteDatabase ();
                    this.destroy ();
                }
                else if (i == 1) {
                    // Open Project
                    //print("Open Project");
                }
            });
        }
    }
}
