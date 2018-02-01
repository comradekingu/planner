namespace Planner {
    public class MainWindow : Gtk.Window {

        AppSettings settings;

        private Headerbar headerbar;
        private WelcomeView welcome;

        public SqliteDatabase db;

        public MainWindow (Gtk.Application application) {
            GLib.Object (
                            application: application,
                            icon_name: "com.github.alainm23.planner",
                            height_request: 700,
                            width_request: 900,
                            title: _("Planner")
                        );
        }

        construct {

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/alainm23/planner/application.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            
            this.db = new SqliteDatabase ();

            build_ui ();

        }

        public void build_ui () {

            headerbar = new Headerbar ();
            set_titlebar (headerbar);

            if ( !Utils.exists_database () ) {
                welcome = new WelcomeView ();
                this.add (welcome);  
            } 
            
        }
    }
}
