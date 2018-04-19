namespace Planner {
    public class InfoPopover : Gtk.Popover {
        private Gtk.Label info_label;

        public InfoPopover (Gtk.Widget relative) {
            relative_to = relative;
            modal = true;
            position = Gtk.PositionType.BOTTOM;

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.margin = 12;
            main_grid.orientation = Gtk.Orientation.VERTICAL;

            info_label = new Gtk.Label ("");
            info_label.use_markup = true;

            main_grid.add (info_label);
            add (main_grid);
        }

        public void set_progres (string value) {
            info_label.label = _("Completed: <b>%s%</b>").printf (value);
        }
    }
}
