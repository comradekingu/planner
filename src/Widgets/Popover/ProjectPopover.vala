namespace Planner {
    public class ProjectPopover : Gtk.Popover {

        private ProjectList project_list;
        private ProjectNewUpdate  project_new_update;
        private Granite.Widgets.Toast notification;
        private SqliteDatabase db;
        private Gtk.Stack   stack;

        // Signal
        public signal void selected_project (Project project);

        private string TITLE_NEW = _("New");
        private string TITLE_EDIT = _("Edit");

        public ProjectPopover (Gtk.Widget relative) {

            GLib.Object (

                modal: true,
                position: Gtk.PositionType.BOTTOM,
                relative_to: relative
            );

            db = new SqliteDatabase (true);

            set_size_request(300, 400);
        }

        construct {

            var grid = new Gtk.Grid ();
            grid.orientation = Gtk.Orientation.VERTICAL;
            grid.expand = true;

            // Stack
            stack = new Gtk.Stack();
            stack.set_transition_duration (400);
            stack.expand = true;
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);

            notification = new Granite.Widgets.Toast (_("Project was created"));
            notification.valign = Gtk.Align.END;

            project_list = new ProjectList ();

            project_new_update = new ProjectNewUpdate ();

            stack.add_named (project_list, "project_list");
            stack.add_named (project_new_update, "project_new_update");

            project_list.add_project.connect ( () => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                stack.visible_child_name = "project_new_update";

                project_new_update.set_title (TITLE_NEW);

            });

            project_new_update.back_action.connect ( () => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                stack.visible_child_name = "project_list";

                project_list.activate_search (false);

            });

            project_new_update.create_update_signal.connect ( (type) => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                stack.visible_child_name = "project_list";

                if (type == "new") {

                    notification.title = _("Project was created");
                
                } else {

                    notification.title = _("Project was updated");

                }
            
                project_list.update_list ();
                project_list.activate_search (false);
                
                notification.send_notification ();
            });

            project_list.delete_project.connect ( (project) => {

                notification.title = _("Delete this project?");

                notification.set_default_action (_("Yes"));

                notification.send_notification ();

                notification.default_action.connect ( () => {

                    db.remove_project (project);

                    project_list.update_list ();

                    notification.set_default_action (null);
                });
            });

            project_list.edit_project.connect ( (project) => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                
                stack.visible_child_name = "project_new_update";
                
                project_new_update.set_title (TITLE_EDIT);

                project_new_update.update_project (project);

            });

            project_list.selected_project.connect ( (project) => {

                hide ();
                
                selected_project (project);

                project_list.activate_search (false);

            });

            project_list.key_press_event.connect ( (key) => {

                project_list.activate_search (true);

            });

            this.closed.connect ( () => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                stack.visible_child_name = "project_list";

                project_new_update.set_title (TITLE_NEW);
                project_new_update.clear_entry ();

                project_list.activate_search (false);
            
            });

            grid.attach (notification, 0, 0, 1, 1);
            grid.attach (stack, 0, 0, 1, 1);
    
            add (grid);
        }

    }
}
