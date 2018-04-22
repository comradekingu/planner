namespace Planner {
    public class TextFormatPopover : Gtk.Popover {
        private Gtk.Button bold_button;
        private Gtk.Button italic_button;
        private Gtk.Button strikethrough_button;

        public TextFormatPopover (Gtk.Widget relative) {
            GLib.Object (
                modal: true,
                position: Gtk.PositionType.TOP,
                relative_to: relative
            );
        }

        construct {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.HORIZONTAL;
            main_grid.column_spacing = 6;
            main_grid.margin = 6;

            bold_button = new Gtk.Button.from_icon_name ("format-text-bold-symbolic", Gtk.IconSize.MENU);
            bold_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            bold_button.clicked.connect ( () => {
                hide ();
            });

            italic_button = new Gtk.Button.from_icon_name ("format-text-italic-symbolic", Gtk.IconSize.MENU);
            italic_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            italic_button.clicked.connect ( () => {
                hide ();
            });

            strikethrough_button = new Gtk.Button.from_icon_name ("format-text-strikethrough-symbolic", Gtk.IconSize.MENU);
            strikethrough_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            strikethrough_button.clicked.connect ( () => {
                hide ();
            });


            main_grid.add (bold_button);
            main_grid.add (italic_button);
            main_grid.add (strikethrough_button);

            add (main_grid);

            main_grid.grab_focus ();
        }
    }
}
