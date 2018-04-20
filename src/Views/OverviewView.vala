namespace Planner {
	public class OverviewView : Gtk.EventBox {
		private LabelWidget all_tasks_label;
		private LabelWidget all_tasks_completed_label;
		private LabelWidget all_lists_label;
		private LabelWidget all_lists_completed_label;

		private Gtk.Image avatar_image;
		private Gtk.Label title_label;
		private Gtk.Label description_label;

		ProgressWidget all_levelbar;

		private Interfaces.Project project_actual;

		private Services.Database db;
		private GLib.Settings settings;

		public OverviewView () {

			get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        	get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);

			db = new Services.Database (true);
			settings = new GLib.Settings ("com.github.alainm23.planner");

			project_actual = new Interfaces.Project ();


			build_ui ();
		}

		private void build_ui () {
			var main_grid  = new Gtk.Grid ();
			main_grid.orientation = Gtk.Orientation.VERTICAL;
			main_grid.row_spacing = 24;
			main_grid.margin = 50;
			main_grid.expand = true;

			string TASKS = _("Tasks");
			string ALL = _("All");
			string COMPLETED = _("Completed");
			string LISTS = _("Lists");

			all_tasks_completed_label = new LabelWidget ("0", TASKS, COMPLETED);
			all_tasks_label = new LabelWidget ("0", ALL, "Tasks");

			avatar_image = new Gtk.Image.from_icon_name (project_actual.avatar, Gtk.IconSize.DND);
			avatar_image.pixel_size = 128;

			all_lists_completed_label = new LabelWidget ("0", LISTS, COMPLETED);
			all_lists_label = new LabelWidget ("0", ALL, LISTS);


			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			box.homogeneous = true;
			box.hexpand = true;
			box.pack_start (all_tasks_completed_label, true, true, 0);
			box.pack_start (all_tasks_label, true, true, 0);
			box.pack_start (avatar_image, true, true, 0);
			box.pack_start (all_lists_completed_label, true, true, 0);
			box.pack_start (all_lists_label, true, true, 0);

			title_label = new Gtk.Label (project_actual.name);
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

			description_label = new Gtk.Label (project_actual.description);
			description_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

			all_levelbar = new ProgressWidget ();
			all_levelbar.margin_top = 12;

			main_grid.add (box);
			main_grid.add (title_label);
			main_grid.add (description_label);
			main_grid.add (all_levelbar);

			add (main_grid);
		}

		public void update_widget () {
			project_actual = db.get_project (settings.get_int ("last-project-id"));

			avatar_image.icon_name = project_actual.avatar;
			title_label.label = project_actual.name;
			description_label.label = project_actual.description;

			if ((db.get_list_length () < 1)) {
				all_tasks_label.update_value ("0");
				all_tasks_completed_label.update_value ("0");

				all_lists_label.update_value ("0");
				all_lists_completed_label.update_value ("0");

				all_levelbar.update_widget ("0");
			} else {
				var all_list = new Gee.ArrayList<Interfaces.List?> ();
				all_list = db.get_all_lists (project_actual.id);

				double all_tasks_completed = 0;
				double all_tasks = 0;
				double list_completed = 0;
				double v = 0;

				foreach (var list in all_list) {
					all_tasks = all_tasks + list.task_all;
					all_tasks_completed = all_tasks_completed + list.tasks_completed;

					if (list.task_all == list.tasks_completed) {
						list_completed = list_completed + 1;
					}
				}


				v = all_tasks_completed * 100 / all_tasks;

				if (all_tasks == 0) {
					v = 0;
				}

				all_tasks_label.update_value (all_tasks.to_string ());
				all_tasks_completed_label.update_value (all_tasks_completed.to_string ());

				all_lists_label.update_value (all_list.size.to_string ());
				all_lists_completed_label.update_value (list_completed.to_string ());

				all_levelbar.update_widget (int.parse (v.to_string ()).to_string ());
			}
		}
	}
}
