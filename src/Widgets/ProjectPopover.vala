namespace Planner {
    public class ProjectPopover : Gtk.Popover {
        
        public MainWindow window { get; construct; }

        ProjectList project_list;
        ProjectNew  project_new;

        Gtk.Stack   stack;
        Gtk.Label   title_label;
        Gtk.Button  add_button;
        public Gtk.Button  save_button;
        Gtk.Button  calcel_button;
        Granite.Widgets.Toast notification; 
        public SqliteDatabase db;

        string new_name = "";
        string new_description = ""; 
        string new_project_type = "";
        string new_start_date = "";
        string new_final_date = "";
        string new_logo = "";

        public ProjectPopover (Gtk.Widget relative) {
            
            GLib.Object (
                modal: true,
                position: Gtk.PositionType.BOTTOM,
                relative_to: relative
            );

            db = new SqliteDatabase (true);
        }

        construct {

            // Main Grid
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.set_margin_bottom (6);
            main_grid.set_margin_top (6);
            main_grid.set_margin_right (12);
            main_grid.set_margin_left (12);
            main_grid.set_size_request(280, 350);
            add (main_grid);

            // Stack
            stack = new Gtk.Stack();
            stack.set_transition_duration (400);
            stack.set_vexpand(true);
            stack.set_hexpand(true);
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);

            // Project Views
            project_list = new ProjectList ();
            project_new = new ProjectNew ();

            stack.add_named (project_list, "project_list");
            stack.add_named (project_new, "project_new");


            // Box Title ad butons
            var v_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            v_box.set_margin_bottom (12);
            v_box.set_margin_top (12);
            
            // Title
            title_label = new Gtk.Label (_("Projects"));
            title_label.halign = Gtk.Align.START;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            // Toast Notifications
            notification = new Granite.Widgets.Toast (_("Project was created!"));

            // Buttons Add, Save and Cancel
            add_button = new Gtk.Button.from_icon_name ("folder-new-symbolic", Gtk.IconSize.MENU);
            add_button.set_has_tooltip (true);
            add_button.set_tooltip_text (_("Create New Project"));
            add_button.clicked.connect ( ()=> {
                
                stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);
                stack.set_visible_child_name("project_new");
                title_label.set_text (_("New Project"));
                save_button.set_visible (true);
                calcel_button.set_visible (true);   
                add_button.set_visible (false); 

            });

            save_button = new Gtk.Button.from_icon_name ("document-save-as-symbolic", Gtk.IconSize.MENU);
            save_button.set_visible (false);
            save_button.set_sensitive (false);
            save_button.set_opacity (0.5);
            save_button.set_no_show_all (true);
            save_button.set_has_tooltip (true);
            save_button.set_tooltip_text (_("Save Project"));

            calcel_button = new Gtk.Button.from_icon_name ("window-close-symbolic", Gtk.IconSize.MENU);
            calcel_button.set_visible (false);
            calcel_button.set_no_show_all (true);
            calcel_button.set_has_tooltip (true);
            calcel_button.set_tooltip_text (_("Cancel"));
            calcel_button.clicked.connect ( () => {

                stack.set_transition_type (Gtk.StackTransitionType.SLIDE_RIGHT);
                stack.set_visible_child_name("project_list");
                title_label.set_text (_("Projects"));
                save_button.set_visible (false);
                calcel_button.set_visible (false);   
                add_button.set_visible (true); 

                // Clear Entrys
                project_new.clear_entry ();
            
            });

            // Signal 
            project_new.new_project.connect ( (name, description, start_date, final_date, logo) => {
                if (name == "") {

                    save_button.set_sensitive (false);
                    save_button.set_opacity (0.5);
                
                } else {
                    new_name = name;
                    new_description = description;
                    new_start_date = start_date;
                    new_final_date = final_date;
                    new_logo = logo;

                    save_button.set_sensitive (true);
                    save_button.set_opacity (1);
                }

            });

            save_button.clicked.connect ( () => {

                db.add_project (new_name, new_description, new_start_date, new_final_date, new_logo);

                stack.set_transition_type (Gtk.StackTransitionType.SLIDE_RIGHT);
                stack.set_visible_child_name("project_list");
                title_label.set_text (_("Projects"));
                save_button.set_visible (false);
                calcel_button.set_visible (false);   
                add_button.set_visible (true); 

                // Clear Entrys
                project_new.clear_entry ();
                
                // Send Notification
                notification.send_notification ();

            });

            var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            
            v_box.pack_start (title_label, false, true, 6);

            v_box.pack_end (add_button, false, true, 6);
            v_box.pack_end (save_button, false, true, 6);
            v_box.pack_end (calcel_button, false, true, 6);

            main_grid.attach (v_box, 0, 0, 1, 1);
            main_grid.attach (separator, 0, 1, 2, 1);
            main_grid.attach (stack, 0, 2, 1, 1);
            main_grid.attach (notification, 0, 3, 1, 1);
        }
    } 
}