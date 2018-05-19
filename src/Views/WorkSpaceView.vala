namespace Planner {
    public class Views.WorkSpaceView : Gtk.Paned {
        public Widgets.WorkList work_list;
        private Widgets.TaskList task_list;

        private Services.Settings settings;

        public WorkSpaceView () {
            get_style_context ().add_class ("welcome");
            margin_top = 24;
            margin_bottom = 12;
            margin_left = 24;
            orientation = Gtk.Orientation.HORIZONTAL;

            settings = new Services.Settings ();
            position = settings.workspace_sidebar_width;

            build_ui ();
        }

        private void build_ui () {
            work_list = new Widgets.WorkList ();
            task_list = new Widgets.TaskList ();

            work_list.on_selected_signal.connect ( (index) => {
                task_list.set_index (index);
            });


            pack1 (work_list, false, false);
            pack2 (task_list, true, true);
        }
    }
}
