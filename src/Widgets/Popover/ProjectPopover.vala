namespace Planner {
    public class ProjectPopover : Gtk.Popover {

        private ProjectList project_list;
        private ProjectNewUpdate  project_new_update;
        private Granite.Widgets.Toast notification;
        private Services.Database db;
        private Gtk.Stack   stack;

        // Signal
        public signal void selected_project (Interfaces.Project project);
        public signal void update_project ();
        public signal void go_startup_view ();
        public signal void go_fist_project ();

        private string TITLE_NEW = _("New");
        private string TITLE_EDIT = _("Edit");

        private GLib.Settings settings;

        public ProjectPopover (Gtk.Widget relative) {

            GLib.Object (

                modal: true,
                position: Gtk.PositionType.BOTTOM,
                relative_to: relative
            );

            db = new Services.Database (true);
            settings = settings = new GLib.Settings ("com.github.alainm23.planner");

            set_size_request(300, 400);
        }

        construct {

            var grid = new Gtk.Grid ();
            grid.orientation = Gtk.Orientation.VERTICAL;
            grid.expand = true;

            // Stack
            stack = new Gtk.Stack();
            stack.transition_duration = 400;
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

            });

            project_new_update.create_update_signal.connect ( (type) => {

                stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                stack.visible_child_name = "project_list";

                if (type == "new") {

                    notification.title = _("Project was created");

                } else {

                    notification.title = _("Project was updated");
                    // AQui EVEnto de update u actualizar Overview
                    update_project ();
                }

                project_list.update_list ();

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

                    if (db.get_project_number () < 1) {
                        go_startup_view ();
                    }else if (project.id == settings.get_int ("last-project-id")) {
                        go_fist_project ();
                    }
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

            });

            this.closed.connect (update_widget);

            grid.attach (notification, 0, 0, 1, 1);
            grid.attach (stack, 0, 0, 1, 1);

            add (grid);

            this.show.connect ( () => {
                project_list.update_list ();
            });
        }

        public void update_widget () {
            stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
            stack.visible_child_name = "project_list";

            project_new_update.set_title (TITLE_NEW);
            project_new_update.clear_entry ();

            hide ();

        }
    }
}
