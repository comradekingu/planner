namespace Planner {
    public class Views.TasksView : Gtk.EventBox {
        public TasksView () {
            build_ui ();
        }

        private void build_ui () {
            var label = new Gtk.Label ("TasksView");
            label.halign = Gtk.Align.CENTER;
            label.valign = Gtk.Align.CENTER;

            add (label);
        }
    }
}
