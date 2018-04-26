namespace Planner {
	public class TaskView : Gtk.Paned {

		private MilestoneList milestones_list;
		private TaskList task_list;

		public signal void update_overview ();

		public TaskView () {
			orientation = Gtk.Orientation.HORIZONTAL;

			get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        	get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);

			build_ui ();
		}

		private void build_ui () {

			milestones_list = new MilestoneList ();
			task_list = new TaskList ();

			milestones_list.list_selected.connect ( (list) => {
				task_list.set_list (list);
			});
			task_list.update_list_all.connect ( () => {
				milestones_list.update_list ();
				update_overview ();
			});

			milestones_list.update_alert.connect ( () => {
				task_list.update_alert ();
			});

			milestones_list.update_list_all.connect ( () => {
				update_overview ();
			});

			pack1 (milestones_list, false, false);
			pack2 (task_list, true, true);
		}

		public void update_widget () {
			milestones_list.update_list ();
			task_list.update_alert ();
			task_list.no_select_list ();
		}

		public void open_create_list () {
			milestones_list.open_create_list ();
		}
	}
}
