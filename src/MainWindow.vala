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
                default_height: 829,
                default_width: 1199,
                title: _("Planner"),
                window_position: Gtk.WindowPosition.CENTER
            );
        }

        construct {

            // Icons Theme
            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/alainm23/planner");

            db = new SqliteDatabase ();

            build_ui ();

        }

        public void build_ui () {

            headerbar = new Headerbar ();
            set_titlebar (headerbar);

            if ( !Utils.exists_database () ) {
                headerbar.disable_all ();
                welcome = new WelcomeView ();

                welcome.enable_headerbar.connect ( () => {
                    headerbar.enable_all ();
                });
                this.add (welcome);  
            } 
            
        }
    }
}
