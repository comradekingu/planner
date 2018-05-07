namespace Planner {
    public class Widgets.ProjectButton : Gtk.ToggleButton {
        Gtk.Label project_title;
        Gtk.Image avatar_image;

        public ProjectButton () {
            get_style_context ().add_class ("project_button");
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            set_focus_on_click (false);

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();

            avatar_image = new Gtk.Image.from_icon_name("planner-startup", Gtk.IconSize.DND);
            avatar_image.pixel_size = 32;
            avatar_image.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

            // Title label
            project_title = new Gtk.Label ("Startup");
            project_title.valign = Gtk.Align.CENTER;
            project_title.vexpand = true;
            project_title.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            main_grid.attach (avatar_image, 0, 0, 1, 2);
            main_grid.attach (project_title, 1, 0, 1, 1);

            add (main_grid);
        }
    }
}
