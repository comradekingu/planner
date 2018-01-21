namespace Planner {
    public class MainWindow : Gtk.Window {

        private Headerbar headerbar;
        private WelcomeView welcome;

        public MainWindow (Gtk.Application application) {

            this.set_application (application);
            this.icon_name = "com.github.alainm23.planner";
            this.title = "Planner";
            this.window_position = Gtk.WindowPosition.CENTER;
            this.set_default_size (1159, 745);

            headerbar = new Headerbar ();
            set_titlebar (headerbar);

            welcome = new WelcomeView ();
            add (welcome);


            //Gtk.MessageDialog msg = new Gtk.MessageDialog (this, Gtk.DialogFlags.MODAL, Gtk.MessageType.WARNING, Gtk.ButtonsType.OK_CANCEL, width.to_string() + " - " + height.to_string());
            //msg.show ();
        }
    }
}
