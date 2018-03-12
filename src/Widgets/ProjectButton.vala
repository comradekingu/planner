namespace Planner {
    public class ProjectButton : Gtk.Button {

        Gtk.Label project_title;
        Gtk.Image avatar_image;

        public ProjectButton () {

            border_width = 4;

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();

            // Title label
            project_title = new Gtk.Label ("");
            project_title.valign = Gtk.Align.CENTER;
            project_title.vexpand = true;
            project_title.margin_start = 5;
            project_title.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            get_style_context ().remove_class ("button");
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            set_focus_on_click (false);

            avatar_image = new Gtk.Image.from_icon_name("planner-startup", Gtk.IconSize.DND);
            avatar_image.pixel_size = 32;

            main_grid.attach (avatar_image, 0, 0, 1, 2);
            main_grid.attach (project_title, 1, 0, 1, 1);

            add (main_grid);
        }

        public void set_project (Project project) {

            project_title.set_label (project.name);
            avatar_image.icon_name = project.avatar;

        }
    }
}
