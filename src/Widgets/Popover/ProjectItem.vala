    
    namespace Planner {
        public class ProjectItem : Gtk.Grid {

        private Project actual_project;

        // Signal to Create Project
        public signal void delete_button_active (Project project);
        public signal void edit_button_active (Project edit);
        
        //public ProjectItem (string id, string name, string description, string logo) {
        public ProjectItem (Project project) {
            
            actual_project = project;
            build_ui (project);
    
        }

        public Project get_project () {

            return actual_project;
        }

        public void build_ui (Project project) {
            
            var image = new Gtk.Image.from_icon_name (project.logo, Gtk.IconSize.DND);
            image.pixel_size = 32;

            var title_label = new Gtk.Label (project.name);
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            title_label.ellipsize = Pango.EllipsizeMode.END;
            title_label.xalign = 0;
            title_label.valign = Gtk.Align.END; 

            var description_label = new Gtk.Label ("<span font_size='small'>" + project.description + "</span>");
            description_label.use_markup = true;
            description_label.ellipsize = Pango.EllipsizeMode.END;
            description_label.xalign = 0;
            description_label.valign = Gtk.Align.START;


            var edit_button = new Gtk.Button.from_icon_name ("document-edit-symbolic",  Gtk.IconSize.MENU);
            edit_button.valign = Gtk.Align.CENTER;
            edit_button.halign = Gtk.Align.END; 
            edit_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            edit_button.set_focus_on_click (false);
            edit_button.set_has_tooltip (true);
            edit_button.set_tooltip_text (_("Edit Project"));
            edit_button.clicked.connect ( () => {
                
                // Send signal to edit a project
                edit_button_active (project);
                
            });

            var delete_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.MENU);
            delete_button.valign = Gtk.Align.CENTER;
            delete_button.halign = Gtk.Align.END; 
            delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            delete_button.set_focus_on_click (false);
            //delete_button.get_style_context ().add_class ("destructive-action");
            delete_button.set_has_tooltip (true);
            delete_button.set_tooltip_text (_("Delete Project"));
            delete_button.clicked.connect ( () => {
            
                // Send signal to delete a project
                delete_button_active (project);

            });

            delete_button.set_focus_on_click (false);

            var action_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 3);
            action_box.expand = true;
            action_box.halign = Gtk.Align.END;

            action_box.pack_start (edit_button, false, false, 3);
            action_box.pack_start (delete_button, false, false, 3);

            margin = 6;
            column_spacing = 12;
            attach (image, 0, 0, 1, 2);
            attach (title_label, 1, 0, 1, 1);
            attach (description_label, 1, 1, 1, 1);
            attach (action_box, 2, 0, 1, 2);

            show_all ();
        }
    }
}