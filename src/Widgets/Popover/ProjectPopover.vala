namespace Planner {
    public class ProjectPopover : Gtk.Popover {

        private ProjectList project_list;
        private ProjectNewUpdate  project_new_update;

        private Gtk.ScrolledWindow list_scrolled_window;


        private Gtk.Stack   stack;
        private Gtk.Label   title_label;
        private Gtk.Button  add_button;
        private Gtk.Button  save_button;
        private Gtk.Button  calcel_button;
        private Granite.Widgets.Toast notification;
        private SqliteDatabase db;

        // Interface
        private Project actual_project;

        // Signal
        public signal void selected_project (Project project);

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
            main_grid.margin_top = 6;
            main_grid.margin_right = 6;
            main_grid.margin_left = 6;
            main_grid.set_size_request(280, 380);

            // Stack
            stack = new Gtk.Stack();
            stack.set_transition_duration (400);
            stack.vexpand = true;
            stack.hexpand = true;
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);

            // Scrolled WIndow
            list_scrolled_window = new Gtk.ScrolledWindow (null, null);

            // Project Views
            project_list = new ProjectList ();


            project_list.set_margin_top (6);

            list_scrolled_window.add (project_list);

            project_new_update = new ProjectNewUpdate ();

            stack.add_named (list_scrolled_window, "project_list");
            stack.add_named (project_new_update, "project_new_update");


            // Box Title ad butons
            var v_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            v_box.margin_bottom = 12;
            v_box.margin_top = 12;

            // Title
            title_label = new Gtk.Label (_("Projects"));
            title_label.halign = Gtk.Align.START;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            // Toast Notifications
            notification = new Granite.Widgets.Toast (_("Project was created"));
            notification.valign = Gtk.Align.END;

            // Buttons Add, Save and Cancel
            add_button = new Gtk.Button.from_icon_name ("folder-new-symbolic", Gtk.IconSize.MENU);
            add_button.width_request = 50;
            add_button.tooltip_text = _("Create a new project");
            add_button.clicked.connect (on_clicked_new);

            save_button = new Gtk.Button.from_icon_name ("document-save-as-symbolic", Gtk.IconSize.MENU);
            save_button.sensitive = false;
            save_button.width_request = 50;
            save_button.set_opacity (0.5);
            save_button.set_no_show_all (true);
            save_button.tooltip_text = _("Save Project");

            calcel_button = new Gtk.Button.from_icon_name ("window-close-symbolic", Gtk.IconSize.MENU);
            calcel_button.set_no_show_all (true);
            calcel_button.width_request = 50;
            calcel_button.tooltip_text = _("Cancel");
            calcel_button.clicked.connect (on_clicked_cancel);

            var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);

            v_box.pack_start (title_label, false, true, 6);

            v_box.pack_end (add_button, false, true, 6);
            v_box.pack_end (save_button, false, true, 6);
            v_box.pack_end (calcel_button, false, true, 6);

            main_grid.attach (v_box, 0, 0, 1, 1);
            main_grid.attach (separator, 0, 1, 2, 1);
            main_grid.attach (notification, 0, 2, 1, 1);
            main_grid.attach (stack, 0, 2, 1, 1);

            add (main_grid);

            update_widget ();
            calcel_button.grab_focus ();

            // ------------ SIGNAL TO CREATE AND EDIT PROJECT -----------
            project_new_update.send_project_data.connect ( (project) => {

                if (project.name == "") {

                    save_button.sensitive = false;
                    save_button.opacity = 0.5;

                } else {

                    actual_project = project;

                    save_button.sensitive = true;
                    save_button.opacity = 1;

                }
            });

            // ------------ BUTTON TO CREATE OR EDIT PROJECT -------------
            save_button.clicked.connect ( () => {

                if (project_new_update.type_widget == "new") {

                    notification.title = _("Project was created");
                    db.add_project (actual_project);

                } else if (project_new_update.type_widget == "edit") {

                    notification.title = _("Project was updated");
                    db.update_project (actual_project);

                }

                // Update List
                project_list.update_list ();

                stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                stack.visible_child_name = "project_list";
                title_label.label = _("Projects");
                save_button.visible = false;
                calcel_button.visible = false;
                add_button.visible = true;

                // Type Widget
                project_new_update.type_widget = "new";

                // Clear Entrys
                project_new_update.clear_entry ();

                // Send Notification
                notification.send_notification ();

            });

            // ----------------- Edit Project ------------------------------------
            project_list.edit_project.connect ( (project) => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                stack.visible_child_name = "project_new_update";
                title_label.label = _("Edit Project");
                save_button.visible = true;
                calcel_button.visible = true;
                add_button.visible = false;

                actual_project = project;

                project_new_update.type_widget = "edit";
                project_new_update.update_project (project);

            });

            // ----------------- DELETE PROJECT ----------------------------------
            project_list.delete_project.connect ( (project) => {

                actual_project = project;

                notification.title = _("Delete this project?");

                notification.set_default_action (_("Yes"));

                notification.send_notification ();

            });

            // ------------- EVENT TO DELETE PROJECT ----------------------------
            notification.default_action.connect (() => {

                // Removed DB
                db.remove_project (actual_project);

                // Update List
                project_list.update_list ();

                notification.set_default_action (null);

            });

            // Event to select to project
            project_list.row_activated.connect (on_project_selected);

            this.closed.connect ( () => {

                update_widget ();
            
            });

            update_widget ();
        }

        private void on_project_selected (Gtk.ListBoxRow list_box_row) {

            var project_row = list_box_row.get_child () as ProjectItem;

            selected_project (project_row.get_project ());

            hide ();

            update_widget ();

            
        }

        public void update_widget () {

            project_list.update_list ();
            
            on_clicked_cancel ();

            calcel_button.grab_focus ();
        }

        private void on_clicked_cancel () {

            stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
            stack.visible_child_name = "project_list";
            title_label.label = _("Projects");
            save_button.visible = false;
            calcel_button.visible = false;
            add_button.visible = true;

            if (project_new_update.type_widget == "new")
            {
                project_new_update.clear_entry ();    
            }
            
            // Type Widget
            project_new_update.type_widget = "new";
        }

        private void on_clicked_new () {

            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
            stack.visible_child_name = "project_new_update";
            title_label.label = _("New Project");
            save_button.visible = true;
            calcel_button.visible = true;
            add_button.visible = false;

            project_new_update.type_widget = "new";

            project_new_update.clear_entry ();
        }
    }
}
