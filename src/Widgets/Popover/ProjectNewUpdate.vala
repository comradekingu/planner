namespace Planner {
    public class ProjectNewUpdate : Gtk.Grid {

        private Gtk.Image avatar_image;
        private Gtk.Button avatar_button;
        private Gtk.Button next_button;
        private Gtk.Button previous_button;

        private Gtk.Revealer revealer_icon_entry;

        private Gtk.Entry icon_entry;   
        private Gtk.Entry name_entry;
        private Gtk.Entry description_entry;

        // Nuevo Widgets Prueba
        private Gtk.Switch type_switch;
        private Gtk.Revealer revealer_datepicker;
        private Granite.Widgets.DatePicker duedate_datepicker;

        private Gee.ArrayList<string> project_types = Utils.project_types ();
        
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
            orientation = Gtk.Orientation.VERTICAL;

            actual_project = new Project ();
            
            build_ui ();

        }

        private void build_ui () {
            
            // avatarar
            avatar_button = new Gtk.Button ();
            avatar_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            avatar_button.clicked.connect ( () => {

            
                if (revealer_icon_entry.reveal_child) {

                    name_entry.grab_focus ();
                    revealer_icon_entry.reveal_child = false;
                    

                } else {

                    icon_entry.grab_focus ();
                    revealer_icon_entry.reveal_child = true;
                
                }
    
            });

            avatar_image = new Gtk.Image.from_icon_name (project_types[index], Gtk.IconSize.DND);
            avatar_image.pixel_size = 64;
            
            avatar_button.image = avatar_image;

            // Next Button
            next_button = new Gtk.Button.from_icon_name ("pan-end-symbolic", Gtk.IconSize.MENU);
            next_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            next_button.set_focus_on_click (false);
            next_button.clicked.connect ( () => {
                
                index = index + 1;
                
                if ( index >= project_types.size ) {
                    index = 0;
                }

                avatar_image.icon_name = project_types[index];
                avatar_button.image = avatar_image;

                update_signal ();

            });

            // Previous button
            previous_button = new Gtk.Button.from_icon_name ("pan-start-symbolic", Gtk.IconSize.MENU);
            previous_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            previous_button.set_focus_on_click (false);
            previous_button.clicked.connect ( () => {
                
                index = index - 1;
                
                if (index <= -1) {
                    index = int.parse (project_types.size.to_string()) - 1;
                }
                
                avatar_image.icon_name = project_types[index];
                avatar_button.image = avatar_image;
                
                update_signal ();

            });

            // Avatar box
            var avatar_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            avatar_box.margin_top = 12;
            avatar_box.pack_start (previous_button, true, true, 0);
            avatar_box.pack_start (avatar_button, false, false, 0);
            avatar_box.pack_start (next_button, true, true, 0);
        
            icon_entry = new Gtk.Entry ();
            icon_entry.margin_top = 12;
            icon_entry.placeholder_text = _("Icon name");
            icon_entry.primary_icon_name = "edit-find-symbolic";
            icon_entry.activate.connect ( () => {

                avatar_image.icon_name = icon_entry.text;
                avatar_button.image = avatar_image;

                revealer_icon_entry.reveal_child = false;

                name_entry.grab_focus ();

                update_signal ();
            
            });

            revealer_icon_entry = new Gtk.Revealer();
            revealer_icon_entry.reveal_child = false;
            revealer_icon_entry.add (icon_entry);

            // Properties project
            name_entry = new Gtk.Entry ();
            name_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.PRIMARY, "application-certificate-symbolic");
            name_entry.margin_top = 12;
            name_entry.max_length = 36;
            name_entry.placeholder_text = _("Name");
            name_entry.changed.connect (update_signal);

            description_entry = new Gtk.Entry ();
            description_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.PRIMARY, "text-x-generic-symbolic");
            description_entry.margin_top = 6;
            description_entry.max_length = 128;
            description_entry.placeholder_text = _("Description");
            description_entry.changed.connect (update_signal);

            var properties_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 3);
            properties_box.pack_start (revealer_icon_entry, true, true, 3);
            properties_box.pack_start (name_entry, true, true, 3);
            properties_box.pack_start (description_entry, true, true, 3);

            type_switch = new Gtk.Switch ();
            type_switch.halign = Gtk.Align.CENTER;
            type_switch.valign = Gtk.Align.CENTER;
            type_switch.notify["active"].connect( () => {

                if (type_switch.active) {
                    
                    var reveal = revealer_datepicker.get_reveal_child();
                    revealer_datepicker.set_reveal_child(!reveal);                    
                    
                } else {
                    revealer_datepicker.reveal_child = false;   
                }

                update_signal ();
            });
            
            var list_label = new Granite.HeaderLabel (_("List"));
            list_label.margin_end = 20;
            list_label.halign = Gtk.Align.END;

            var milestones = new Granite.HeaderLabel (_("Milestones"));
            milestones.margin_start = 10;
            milestones.halign = Gtk.Align.START;

            var type_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            //type_box.margin_top = 12;
            type_box.halign = Gtk.Align.CENTER;
            type_box.homogeneous = true;

            type_box.pack_start (list_label, true, true, 0);
            type_box.pack_start (type_switch, true, true, 0);
            type_box.pack_end (milestones, true, true, 0);


            duedate_datepicker = new Granite.Widgets.DatePicker();
            duedate_datepicker.changed.connect (update_signal);

            revealer_datepicker = new Gtk.Revealer();
            revealer_datepicker.reveal_child = false;
            
            var datepicker_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            datepicker_box.pack_start (new Granite.HeaderLabel (_("Deadline")));
            datepicker_box.pack_start (duedate_datepicker);

            revealer_datepicker.add (datepicker_box);

            add (avatar_box);
            add (properties_box);
            add (new Granite.HeaderLabel (_("Project Type")));
            add (type_box);
            add (revealer_datepicker);

            name_entry.grab_focus ();
        }

        public void update_signal () {

            var datetime = new GLib.DateTime.now_local ();
            
            string start_date = datetime.format ("%F");
            string due_date = "";

            string type_project = "lists";
            
            if (type_switch.get_state ()) {

                type_project = "milestones";
                due_date = duedate_datepicker.date.format ("%F");
            }

            actual_project.name = name_entry.text;
            actual_project.description = description_entry.text;
            actual_project.type = type_project;
            actual_project.avatar = avatar_image.icon_name;
            actual_project.start_date = start_date;
            actual_project.due_date = due_date;

            send_project_data (actual_project);

        }

        public void clear_entry () {
            
            name_entry.text = "";
            description_entry.text = "";
            icon_entry.text = "";
                
            index = 0;
            avatar_image.icon_name = project_types[index];
            avatar_button.image = avatar_image;

            type_switch.active = false;
            revealer_datepicker.reveal_child = false;

        }

        public void update_project (Project project) {

            // Set Avatar
            avatar_image.icon_name = project.avatar;
            icon_entry.text = project.avatar;
            avatar_button.image = avatar_image;

            // Set Name and Description
            name_entry.text = project.name;
            description_entry.text = project.description;

            // Set Datetime 
            if (project.due_date == "") {
                
                revealer_datepicker.reveal_child = false;
            
            } else {
                
                revealer_datepicker.reveal_child = true;
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