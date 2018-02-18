namespace Planner {
    public class ProjectNew : Gtk.Grid {

        //public MainWindow window { get; construct; }

        private Gtk.Image logo_image;
        private Gtk.Button next_button;
        private Gtk.Button previous_button;

        private Gtk.Entry  project_name_entry;
        private Gtk.Entry  project_description_entry;

        private Gtk.Switch deadline_switch;
        private Granite.Widgets.DatePicker deadline_datepicker;

        private Array<string> project_types = new Array<string> ();
        
        public signal void new_project (string name, string description, string start_date, string final_date, string logo);
        //, string start_date, string final_date, string logo 

        private int index = 0;


        public ProjectNew () {
            
            set_margin_top (6);
            column_spacing = 12;
            row_spacing = 6;
            column_homogeneous = true;

            build_ui ();
        }

        private void build_ui () {

            project_types.append_val ("planner-startup");
            project_types.append_val ("planner-checklist");
            project_types.append_val ("planner-computer");
            project_types.append_val ("planner-code");
            project_types.append_val ("planner-pen");
            project_types.append_val ("planner-web");
            project_types.append_val ("planner-video-player");
            project_types.append_val ("planner-online-shop");
            project_types.append_val ("planner-team");
            
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
            });

            deadline_datepicker = new Granite.Widgets.DatePicker();
            deadline_datepicker.set_visible (false);
            deadline_datepicker.set_no_show_all (true);

            var deadline_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            deadline_box.set_margin_top (12);
            deadline_box.pack_start (deadline_label, false, false, 0);
            deadline_box.pack_end (deadline_switch, false, false, 0);

            attach (avatar_box, 0, 0, 1, 1);
            attach (properties_box, 0, 1, 1, 1);
            attach (deadline_box, 0, 2, 1, 1);
            attach (deadline_datepicker, 0, 3, 1, 1);
        }

        public void update_signal () {

            new_project (
                project_name_entry.get_text (),         // Project Name
                project_description_entry.get_text (),  // Project Description
                "",                                     // Start Date
                "",                                     // Final Date
                project_types.index (index)             // Logo
            );


        }

        public void clear_entry () {
            // Clear Entrys
            project_name_entry.set_text ("");
            project_description_entry.set_text ("");
            index = 0;
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