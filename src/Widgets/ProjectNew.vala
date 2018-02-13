namespace Planner {
    public class ProjectNew : Gtk.Grid {

        private Gtk.Image logo_image;
        private Gtk.Button next_button;
        private Gtk.Button previous_button;

        private Gtk.Entry  project_name_entry;
        private Gtk.Entry  project_description_entry;

        private Gtk.Switch deadline_switch;
        private Granite.Widgets.DatePicker deadline_datepicker;

        private Array<string> project_types = new Array<string> ();
        
        private int index = 2;


        public ProjectNew () {
            
            set_margin_top (6);
            column_spacing = 12;
            row_spacing = 6;
            column_homogeneous = true;
            
            build_ui ();
        }

        private void build_ui () {

            project_types.append_val ("planner-checklist");
            project_types.append_val ("planner-computer");
            project_types.append_val ("planner-startup");
            project_types.append_val ("planner-code");
            project_types.append_val ("planner-pen");
            project_types.append_val ("planner-web");
            project_types.append_val ("planner-video-player");
            project_types.append_val ("planner-online-shop");
            project_types.append_val ("planner-team");


            
            //project_types.index (index)
            logo_image = new Gtk.Image.from_icon_name ("planner-computer", Gtk.IconSize.DIALOG);
            logo_image.get_style_context ().add_class (Granite.STYLE_CLASS_AVATAR);

            next_button = new Gtk.Button.from_icon_name ("pan-end-symbolic", Gtk.IconSize.MENU);
            next_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            next_button.clicked.connect ( () => {
                index++;
                logo_image.icon_name = project_types.index (index);
            });

            previous_button = new Gtk.Button.from_icon_name ("pan-start-symbolic", Gtk.IconSize.MENU);
            previous_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            previous_button.clicked.connect ( () => {
                index--;
                logo_image.icon_name = project_types.index (index);
            });
            // Avatar box
            var avatar_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            avatar_box.pack_start (previous_button, true, true, 0);
            avatar_box.pack_start (logo_image, false, false, 0);
            avatar_box.pack_start (next_button, true, true, 0);

            // Properties project
            project_name_entry = new Gtk.Entry ();
            project_name_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.PRIMARY, "application-certificate-symbolic");
            project_name_entry.set_placeholder_text (_("Name"));

            project_description_entry = new Gtk.Entry ();
            project_description_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.PRIMARY, "text-x-generic-symbolic");
            project_description_entry.set_placeholder_text (_("Description"));

            var properties_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 3);
            properties_box.pack_start (project_name_entry, true, true, 3);
            properties_box.pack_start (project_description_entry, true, true, 3);

            // Properties deadline
            var deadline_label = new Gtk.Label (_("Deadline"));
            deadline_label.halign = Gtk.Align.START;
            //deadline_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            
            deadline_switch = new Gtk.Switch ();
            //deadline_switch.get_style_context ().add_class ();
            deadline_switch.halign = Gtk.Align.END;
            deadline_switch.notify["active"].connect( () => {
                if (deadline_switch.get_active()) {
                    deadline_datepicker.set_visible (true);
                } else {
                    deadline_datepicker.set_visible (false);
                }
            });

            deadline_datepicker = new Granite.Widgets.DatePicker ();
            deadline_datepicker.set_visible (false);
            deadline_datepicker.set_no_show_all (true);

            var deadline_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            deadline_box.pack_start (deadline_label, false, false, 0);
            deadline_box.pack_end (deadline_switch, false, false, 0);

            attach (avatar_box, 0, 0, 1, 1);
            attach (properties_box, 0, 1, 1, 1);
            attach (deadline_box, 0, 2, 1, 1);
            attach (deadline_datepicker, 0, 3, 1, 1);
        }
    }  
}