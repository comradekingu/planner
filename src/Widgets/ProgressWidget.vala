namespace Planner {
    public class ProgressWidget : Gtk.Grid {
        private Gtk.Label value_label;
        private Gtk.LevelBar all_levelbar;

        public ProgressWidget () {
            hexpand = true;
            margin_left = 50;
            margin_right = 50;

            build_ui ();
        }
        private void build_ui () {
            var main_grid = new Gtk.Grid ();

            all_levelbar = new Gtk.LevelBar.for_interval (0, 100);
            all_levelbar.hexpand = true;
            all_levelbar.height_request = 20;

            value_label = new Gtk.Label ("");
            value_label.use_markup = true;
            value_label.label = _("Completed: <b>%s%</b>").printf("0");

            main_grid.attach (value_label, 0, 0, 1, 1);
            main_grid.attach (all_levelbar, 0, 0, 1, 1);

            add (main_grid);
        }

        public void update_widget (string value) {
            value_label.label = _("Completed: <b>%s%</b>").printf(value);
            all_levelbar.value = int.parse (value);
        }
    }
}
