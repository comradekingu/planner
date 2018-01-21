namespace Planner {
    public class Planner : Gtk.Application {
        public Planner () {
            Object (application_id: "com.github.alainm23.planner",
            flags: ApplicationFlags.FLAGS_NONE);
        }

        protected override void activate () {
            var app_window = new MainWindow (this);
            app_window.show_all ();

            var quit_action = new SimpleAction ("quit", null);

            add_action (quit_action);
            add_accelerator ("<Control>q", "app.quit", null);

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
