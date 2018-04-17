namespace Planner {
    public class Planner : Gtk.Application {
        public Planner () {
            Object (
                application_id: "com.github.alainm23.planner",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {
            
            var app_window = new MainWindow (this);
            app_window.show_all ();
      
            var quit_action = new SimpleAction ("quit", null);

            add_action (quit_action);
            add_accelerator ("<Control>q", "app.quit", null);

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/alainm23/planner/stylesheet.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            quit_action.activate.connect (() => {
                if (app_window != null) {
                    app_window.destroy ();
                }
            });
        }


        private static int main (string[] args) {
            Gtk.init (ref args);

            var app = new Planner ();
            return app.run (args);
        }
    }
}
