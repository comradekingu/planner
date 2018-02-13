namespace Planner {
    public class MainWindow : Gtk.Window {

        AppSettings settings;

        private Headerbar headerbar;
        private WelcomeView welcome;

        public SqliteDatabase db;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                icon_name: "com.github.alainm23.planner",
                height_request: 829,
                width_request: 1199,
                title: _("Planner"),
                window_position: Gtk.WindowPosition.CENTER
            );
        }

        construct {

            // Icons Theme
            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/alainm23/planner");

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
