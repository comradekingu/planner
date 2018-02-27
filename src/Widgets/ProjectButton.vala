namespace Planner { 
    public class ProjectButton : Gtk.Grid {
        
        Gtk.Label   project_title;
        Gtk.Label   project_description;
        Gtk.Button  icon;

        construct {
            
            // Title label
            project_title = new Gtk.Label ("Project title");
            project_title.margin_left = 6;
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

            icon = new Gtk.Button.from_icon_name("planner-startup", Gtk.IconSize.DND);
            
            icon.clicked.connect ( () => {
                var popover = new ProjectPopover (icon);
                popover.show_all ();
            });

            attach (icon, 0, 0, 1, 2);
            attach (project_title, 1, 0, 1, 1);
        }
    }
}