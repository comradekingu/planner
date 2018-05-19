namespace Planner {
    public class Widgets.TodayNotification : Gtk.EventBox {
        private Granite.Widgets.ModeButton mode_button;
        private Gtk.Stack main_stack;
        private Widgets.NotificationsGrid notifications_grid;
        private Widgets.TasksGrid tasks_grid;

        public TodayNotification () {

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;

            main_stack = new Gtk.Stack ();
            //main_stack.transition_duration = 400;
            main_stack.expand = true;
            main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;

            notifications_grid = new Widgets.NotificationsGrid ();
            tasks_grid =  new Widgets.TasksGrid ();

            main_stack.add_named (notifications_grid, "notifications_grid");
            main_stack.add_named (tasks_grid, "tasks_grid");
            main_stack.visible_child_name = "notifications_grid";

            var notifications = new FormatButton ();
            notifications.icon = new ThemedIcon ("notification-symbolic");
            notifications.text = _("Notifications");
            notifications.width_request = 120;

            var tasks = new FormatButton ();
            tasks.icon = new ThemedIcon ("emblem-default-symbolic");
            tasks.text = _("Tasks");

            mode_button = new Granite.Widgets.ModeButton ();
            mode_button.hexpand = true;
            mode_button.halign = Gtk.Align.CENTER;

            mode_button.append (notifications);
            mode_button.append (tasks);
            mode_button.selected = 0;

            mode_button.mode_changed.connect ( (widget) => {
                if (mode_button.selected == 0) {
                    main_stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                    main_stack.visible_child_name = "notifications_grid";
                } else {
                    main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                    main_stack.visible_child_name = "tasks_grid";
                }
            });

            main_grid.add (mode_button);
            main_grid.add (main_stack);

            add (main_grid);
        }
    }
}
