namespace Planner { 
    public class ProjectButton : Gtk.Button {
        
        Gtk.Label   project_title;
        Gtk.Label   project_description;
        Gtk.Image?  _icon;
        Gtk.Grid    project_grid;
        
        construct {
            
            // Title label
            project_title = new Gtk.Label ("Project title");
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

            // Img
            var username = GLib.Environment.get_user_name ();
            var iconfile = @"/var/lib/AccountsService/icons/$username";

            var avatar_default_dnd = new Granite.Widgets.Avatar.with_default_icon (32);

            // Button contents wrapper
            project_grid = new Gtk.Grid ();
            //project_grid.column_spacing = 12;

            project_grid.attach (avatar_default_dnd, 0, 0, 1, 2);
            project_grid.attach (project_title, 1, 0, 1, 1);
            project_grid.attach (project_description, 1, 1, 1, 1);
            this.add (project_grid);
        }
    }
}