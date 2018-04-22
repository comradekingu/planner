namespace Planner {
    public class ModelButton : Gtk.Button {
        private Gtk.Image icon;
        private Gtk.Label label;

        public ModelButton (string text = "", string icon_name = "") {
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            tooltip_text = _("Create a new List");

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.HORIZONTAL;

            icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.SMALL_TOOLBAR);
            icon.opacity = 0.80;

            label = new Gtk.Label ("<b>" + text + "</b>");
            label.use_markup = true;
            label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            main_grid.add (icon);
            main_grid.add (label);

            add (main_grid);
        }
    }
}
