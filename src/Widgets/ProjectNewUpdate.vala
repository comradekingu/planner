namespace Planner {
    public class ProjectNewUpdate : Gtk.Grid {

        private Gtk.Image logo_image;
        private Gtk.Button next_button;
        private Gtk.Button previous_button;

        private Gtk.Entry  project_name_entry;
        private Gtk.Entry  project_description_entry;

        private Gtk.Switch deadline_switch;
        private Granite.Widgets.DatePicker deadline_datepicker;

        private Array<string> project_types = new Array<string> ();
        
        // Signal to Create Project
        public signal void send_project_data (Project project);

        private string _type_widget;

        private int index = 0;

        private Project actual_project;

        public ProjectNewUpdate () {
            
            margin_top = 6;
            column_spacing = 12;
            row_spacing = 6;
            column_homogeneous = true;

            actual_project = new Project ();
                                                                // Index
            project_types.append_val ("planner-startup");       // 0
            project_types.append_val ("planner-checklist");     // 1
            project_types.append_val ("planner-computer");      // 2
            project_types.append_val ("planner-code");          // 3
            project_types.append_val ("planner-pen");           // 4
            project_types.append_val ("planner-web");           // 5
            project_types.append_val ("planner-video-player");  // 6
            project_types.append_val ("planner-online-shop");   // 7
            project_types.append_val ("planner-team");          // 8

            build_ui ();

        }

        private void build_ui () {
            
            // Logo
            logo_image = new Gtk.Image.from_icon_name (project_types.index (index), Gtk.IconSize.DIALOG);

            // Next Button
            next_button = new Gtk.Button.from_icon_name ("pan-end-symbolic", Gtk.IconSize.MENU);
            next_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            next_button.set_focus_on_click (false);
            next_button.clicked.connect ( () => {
                
                index = index + 1;
                
                if ( index >= project_types.length ) {
                    index = 0;
                }

                logo_image.icon_name = project_types.index (index);
                update_signal ();

            });

            // Previous button
            previous_button = new Gtk.Button.from_icon_name ("pan-start-symbolic", Gtk.IconSize.MENU);
            previous_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            previous_button.set_focus_on_click (false);
            previous_button.clicked.connect ( () => {
                
                index = index - 1;
                
                if (index <= -1) {
                    index = int.parse (project_types.length.to_string()) - 1;
                }
                
                logo_image.icon_name = project_types.index (index);
                update_signal ();

            });

            // Avatar box
            var avatar_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            avatar_box.set_margin_top (12);
            avatar_box.pack_start (previous_button, true, true, 0);
            avatar_box.pack_start (logo_image, false, false, 0);
            avatar_box.pack_start (next_button, true, true, 0);

            // Properties project
            project_name_entry = new Gtk.Entry ();
            project_name_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.PRIMARY, "application-certificate-symbolic");
            project_name_entry.set_margin_top (12);
            project_name_entry.set_placeholder_text (_("Name"));
            project_name_entry.changed.connect (update_signal);

            project_description_entry = new Gtk.Entry ();
            project_description_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.PRIMARY, "text-x-generic-symbolic");
            project_description_entry.set_margin_top (6);
            project_description_entry.set_placeholder_text (_("Description"));
            project_description_entry.changed.connect (update_signal);

            var properties_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 3);
            properties_box.pack_start (project_name_entry, true, true, 3);
            properties_box.pack_start (project_description_entry, true, true, 3);

            // Properties deadline
            var deadline_label = new Gtk.Label (_("Deadline"));
            deadline_label.halign = Gtk.Align.START;
            deadline_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            
            deadline_switch = new Gtk.Switch ();
            deadline_switch.valign = Gtk.Align.CENTER;
            deadline_switch.halign = Gtk.Align.END;
            deadline_switch.notify["active"].connect( () => {

                if (deadline_switch.get_active()) {
                    deadline_datepicker.set_visible (true);
                } else {
                    deadline_datepicker.set_visible (false);
                }

                update_signal ();

            });

            deadline_datepicker = new Granite.Widgets.DatePicker();
            deadline_datepicker.set_visible (false);
            deadline_datepicker.set_no_show_all (true);
            deadline_datepicker.changed.connect (update_signal);

            var deadline_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            deadline_box.set_margin_top (12);
            deadline_box.pack_start (deadline_label, false, false, 0);
            deadline_box.pack_end (deadline_switch, false, false, 0);

            attach (avatar_box, 0, 0, 1, 1);
            attach (properties_box, 0, 1, 1, 1);
            attach (deadline_box, 0, 2, 1, 1);
            attach (deadline_datepicker, 0, 3, 1, 1);

            project_name_entry.grab_focus ();
        }

        public void update_signal () {

            var datetime = new GLib.DateTime.now_local ();
            
            string start_date = datetime.format ("%F");
            string final_date = "";
            
            if (deadline_switch.get_state ()) {
                
                final_date = deadline_datepicker.date.format ("%F");
            }

            actual_project.name = project_name_entry.get_text ();
            actual_project.description = project_description_entry.get_text ();
            actual_project.logo = project_types.index (index);
            actual_project.start_date = start_date;
            actual_project.final_date = final_date;

            send_project_data (actual_project);

        }

        public void clear_entry () {
            
            project_name_entry.set_text ("");
            project_description_entry.set_text ("");
            index = 0;
            deadline_switch.set_state (false);

        }

        public void update_project (Project project) {

            // Set logo 
            for (int i = 0; i < project_types.length; i++) {
                
                if (project_types.index (i) == project.logo) {
                    logo_image.icon_name = project_types.index (i);
                }
            }

            // Set Name and Description
            project_name_entry.set_text (project.name);
            project_description_entry.set_text (project.description);

            // Set Datetime 
            if (project.final_date == "") {
                
                deadline_datepicker.set_visible (false);
            
            } else {
                
                deadline_switch.set_state (true);
                deadline_datepicker.set_visible (true);

            }

            actual_project = project;
        }

        public string type_widget {

            get {
                return _type_widget;
            }
            construct set {
                _type_widget = value;
            }
        }
    }  
}
/*

var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (name, description, "dialog-warning", Gtk.ButtonsType.CANCEL);
            
message_dialog.transient_for = window;
message_dialog.show_all ();
message_dialog.run ();
message_dialog.destroy ();

*/