namespace Planner {
    public class Headerbar : Gtk.HeaderBar {
        
        //stacks
        //private Gtk.Stack stack;
        //private Gtk.StackSwitcher stack_switcher;
        private ProjectButton projectbutton;

        public Headerbar () {
            set_title ("Planner");
            set_show_close_button (true);

            var style_context = get_style_context ();
            style_context.add_class ("format-bar");
            style_context.add_class (Gtk.STYLE_CLASS_LINKED);

            build_ui ();
        }

        private void build_ui () {
        
            projectbutton = new ProjectButton ();
            this.pack_start (projectbutton);
            /* stack init
            stack = new Gtk.Stack ();
            stack_switcher = new Gtk.StackSwitcher ();
            stack_switcher.set_stack (stack);
            stack_switcher.set_halign (Gtk.Align.CENTER);

            this.set_custom_title (stack_switcher);
            */
        }

        public void disable_all () {
            
            // Disable buttons
            projectbutton.set_sensitive (false);
            projectbutton.set_opacity (0.5);

        }

        public void enable_all () {

            // Enable Buttons
            projectbutton.set_sensitive (true);
            projectbutton.set_opacity (1);

        }
    }
}
