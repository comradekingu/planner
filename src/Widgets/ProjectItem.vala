namespace Planner {
        public class ProjectItem : Gtk.EventBox {

        private Interfaces.Project actual_project;

        // Signal to Create Project
        public signal void delete_button_active (Interfaces.Project project);
        public signal void edit_button_active (Interfaces.Project edit);

        //public ProjectItem (string id, string name, string description, string logo) {
        public ProjectItem (Interfaces.Project project) {

            can_focus = false;
            actual_project = project;
            build_ui ();

        }

        public Interfaces.Project get_project () {

            return actual_project;
        }

        public void build_ui () {

            var grid = new Gtk.Grid ();
            grid.margin_top = 8;
            grid.margin_bottom = 8;

            var image = new Gtk.Image.from_icon_name (actual_project.avatar, Gtk.IconSize.DND);
            image.pixel_size = 32;

            var title_label = new Gtk.Label (actual_project.name);
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            title_label.ellipsize = Pango.EllipsizeMode.END;
            title_label.xalign = 0;
            title_label.valign = Gtk.Align.END;

            var description_label = new Gtk.Label ("<span font_size='small'>" + actual_project.description + "</span>");
            description_label.use_markup = true;
            description_label.ellipsize = Pango.EllipsizeMode.END;
            description_label.xalign = 0;
            description_label.valign = Gtk.Align.START;


            var edit_button = new Gtk.Button.from_icon_name ("document-edit-symbolic",  Gtk.IconSize.MENU);
            edit_button.valign = Gtk.Align.CENTER;
            edit_button.halign = Gtk.Align.END;
            edit_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            edit_button.set_focus_on_click (false);
            edit_button.tooltip_text = _("Edit Project");
            edit_button.clicked.connect ( () => {

                // Send signal to edit atu project
                edit_button_active (actual_project);

            });

            var delete_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.MENU);
            delete_button.valign = Gtk.Align.CENTER;
            delete_button.halign = Gtk.Align.END;
            delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            delete_button.set_focus_on_click (false);
            delete_button.tooltip_text = _("Delete Project");
            delete_button.clicked.connect ( () => {

                // Send signal to delete a project
                delete_button_active (actual_project);

            });

            delete_button.set_focus_on_click (false);

            var action_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 3);
            action_box.expand = true;
            action_box.halign = Gtk.Align.END;
            action_box.visible = false;

            action_box.pack_start (edit_button, false, false, 3);
            action_box.pack_start (delete_button, false, false, 3);

            var action_revealer = new Gtk.Revealer ();
            action_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            action_revealer.add (action_box);
            action_revealer.show_all ();
            action_revealer.set_reveal_child (false);


            this.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
            this.enter_notify_event.connect ( (event) => {

                action_revealer.set_reveal_child (true);
                action_box.visible = true;

                return false;

            });

            this.leave_notify_event.connect ((event) => {

                if (event.detail == Gdk.NotifyType.INFERIOR) {

                    return false;

                }

                action_revealer.set_reveal_child (false);
                action_box.visible = false;
                //settings_revealer.set_reveal_child (false);

                return false;
            });

            grid.column_spacing = 12;
            grid.attach (image, 0, 0, 1, 2);
            grid.attach (title_label, 1, 0, 1, 1);
            grid.attach (description_label, 1, 1, 1, 1);
            //grid.attach (settings_revealer, 2, 0, 1, 2);
            grid.attach (action_revealer, 2, 0, 2, 2);

            add (grid);

            show_all ();
        }
    }
}
