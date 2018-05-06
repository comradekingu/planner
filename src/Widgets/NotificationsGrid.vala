namespace Planner {
    public class Widgets.NotificationsGrid : Gtk.Grid {
        public NotificationsGrid () {
            var alert = new Granite.Widgets.AlertView (_("No notification"), _("You don't have any new notifications"), "planner-notification");
            alert.get_style_context ().remove_class ("view");

            add (alert);
        }
    }
}
