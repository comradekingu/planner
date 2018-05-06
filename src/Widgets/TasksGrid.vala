namespace Planner {
    public class Widgets.TasksGrid : Gtk.Grid {
        public TasksGrid () {
            var alert = new Granite.Widgets.AlertView (_("No task"), _("You don't have any new tasks"), "emblem-default");
            alert.get_style_context ().remove_class ("view");

            add (alert);
        }
    }
}
