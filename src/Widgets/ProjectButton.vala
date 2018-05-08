namespace Planner {
    public class Widgets.ProjectButton : Gtk.ToggleButton {
        private Gtk.Label project_title;
        private Gtk.Image avatar_image;
        private Granite.Widgets.Avatar avatar;

        private Services.Database db;

        public ProjectButton () {
            get_style_context ().remove_class ("button");
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            set_focus_on_click (false);

            db = new Services.Database (true);

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.column_spacing = 6;

            avatar_image = new Gtk.Image.from_icon_name("planner-startup", Gtk.IconSize.DND);
            avatar_image.pixel_size = 32;
            avatar_image.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

            avatar = new Granite.Widgets.Avatar ();
            // Title label
            project_title = new Gtk.Label ("Startup");
            project_title.valign = Gtk.Align.CENTER;
            project_title.vexpand = true;
            project_title.set_ellipsize (Pango.EllipsizeMode.END);
            project_title.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            main_grid.attach (avatar_image, 0, 0, 1, 2);
            main_grid.attach (avatar, 0, 0, 1, 2);
            main_grid.attach (project_title, 1, 0, 1, 1);

            add (main_grid);
        }

        public void set_project (Objects.Project project) {
            Objects.Project project_object = db.get_project (project.id);
            project_title.label = project_object.name;

            if (Utils.is_avatar_icon (project_object.avatar)) {
                avatar_image.icon_name = project_object.avatar;

                avatar.no_show_all = true;
                avatar.visible = false;

                avatar_image.no_show_all = false;
                avatar_image.visible = true;
            } else {
                string path = Environment.get_home_dir () +
                    "/.local/share/com.github.alainm23.planner/project-avatar/" +
                    project_object.avatar;
                var avatar_pixbuf = new Gdk.Pixbuf.from_file_at_scale (path, 24, 24, true);
                avatar.pixbuf = avatar_pixbuf;

                avatar.no_show_all = false;
                avatar.visible = true;

                avatar_image.no_show_all = true;
                avatar_image.visible = false;
            }
        }
    }
}
