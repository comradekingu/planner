namespace Planner {
    public class FilterListPopover : Gtk.Popover {
        public FilterListPopover (Gtk.Widget relative) {
            GLib.Object (
                modal: true,
                position: Gtk.PositionType.TOP,
                relative_to: relative
            );
        }

        construct {
            var main_grid = new Gtk.Grid ();
            main_grid.margin = 6;
            main_grid.orientation = Gtk.Orientation.VERTICAL;

            var r1 = new Gtk.RadioButton.with_label_from_widget (null, _("Name (A - Z)"));
            var r2 = new Gtk.RadioButton.with_label_from_widget (r1, _("Name (Z - A)"));
            var r3 = new Gtk.RadioButton.with_label_from_widget (r1, _("Date (First)"));
            var r4 = new Gtk.RadioButton.with_label_from_widget (r1, _("Date (latest)"));
            var r5 = new Gtk.RadioButton.with_label_from_widget (r1, _("Tasks (higher)"));
            var r6 = new Gtk.RadioButton.with_label_from_widget (r1, _("Tasks (less)"));

            main_grid.add (r1);
            main_grid.add (r2);
            main_grid.add (r3);
            main_grid.add (r4);
            main_grid.add (r5);
            main_grid.add (r6);

            add (main_grid);
        }
    }
}
