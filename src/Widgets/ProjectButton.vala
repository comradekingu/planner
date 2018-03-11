namespace Planner {
    public class ProjectButton : Gtk.Button {

        Gtk.Label project_title;
        Gtk.Label project_description;
        Gtk.Image image;

        public ProjectButton () {

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();


            // Title label
            project_title = new Gtk.Label ("");
            project_title.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            project_title.halign = Gtk.Align.START;
            project_title.valign = Gtk.Align.END;

            // Description label
            project_description = new Gtk.Label ("project description");
            project_description.halign = Gtk.Align.START;
            project_description.valign = Gtk.Align.START;
            project_description.set_line_wrap (true);
            project_description.set_line_wrap_mode (Pango.WrapMode.WORD);
            project_description.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            set_focus_on_click (false);

            image = new Gtk.Image.from_icon_name("planner-startup", Gtk.IconSize.DND);
            image.pixel_size = 32;

            main_grid.attach (image, 0, 0, 1, 2);
            main_grid.attach (project_title, 1, 0, 1, 1);

            add (main_grid);
        }

        public void set_project (Project project) {

            project_title.set_label (project.name);
            image.icon_name = project.avatar;

        }
    }
}
