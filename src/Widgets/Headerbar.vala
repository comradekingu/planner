namespace Planner {
    public class Headerbar : Gtk.HeaderBar {
        public Headerbar () {
            set_title ("Planner");
            set_show_close_button (true);

            var style_context = get_style_context ();
            style_context.add_class ("format-bar");
            style_context.add_class (Gtk.STYLE_CLASS_LINKED);


        }
    }
}
