namespace Planner {
	public class MilestoneList : Gtk.Grid {
		private Gtk.Label title_label;
        private Gtk.ListBox milestone_list;

		private ModelButton add_button;
		private Gtk.Button filter_button;

		private NewEditListPopover new_list_popover;
		private FilterListPopover filter_popover;
        private Gtk.ScrolledWindow list_scrolled_window;

        private Services.Database db;
        private GLib.Settings settings;

        public signal void list_selected (Interfaces.List list);

		private double all_tasks_progress = 0;
		private double all_tasks_completed_progress = 0;

		private const string color_low = "#c6262e";
		private const string color_medium = "#f37329";
		private const string color_completed = "#68b723";

		public signal void update_alert ();
		public signal void update_list_all ();
		public MilestoneList () {
            db = new Services.Database (true);
            settings = new GLib.Settings ("com.github.alainm23.planner");

			orientation = Gtk.Orientation.VERTICAL;
            row_spacing = 12;
            margin = 25;
			margin_bottom = 13;
			expand = true;
			width_request = 270;

			build_ui ();
		}

		private void build_ui () {
			title_label = new Gtk.Label (_("<b>Lists</b>"));
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.halign = Gtk.Align.START;
			title_label.margin_left = 8;
            title_label.use_markup = true;

			add_button = new ModelButton (_("New list"), "list-add-symbolic");
            add_button.halign = Gtk.Align.END;
            add_button.valign = Gtk.Align.CENTER;
            add_button.clicked.connect ( () => {
            	new_list_popover.show_all ();
            });

			filter_button = new Gtk.Button.from_icon_name ("planner-levels-symbolic", Gtk.IconSize.MENU);
			filter_button.tooltip_text = _("Filter Lists by");
			filter_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

			var actionbar_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			actionbar_box.pack_start (add_button, false, false, 0);

            new_list_popover = new NewEditListPopover (add_button);
            new_list_popover.update_list.connect ( () => {
				update_list ();
				update_list_all ();
            });

			filter_popover = new FilterListPopover (filter_button);
			filter_button.clicked.connect ( () => {
				filter_popover.show_all ();
			});

            milestone_list = new Gtk.ListBox ();
            milestone_list.activate_on_single_click = true;
            milestone_list.selection_mode = Gtk.SelectionMode.NONE;

            list_scrolled_window = new Gtk.ScrolledWindow (null, null);
            list_scrolled_window.expand = true;
            list_scrolled_window.add (milestone_list);

            add (title_label);
			add (list_scrolled_window);
			add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
			add (actionbar_box);
        }

        private void create_list () {
            var all_list = new Gee.ArrayList<Interfaces.List?> ();

			all_list = db.get_all_lists (settings.get_int ("last-project-id"));

			foreach (var list in all_list) {
				all_tasks_progress = all_tasks_progress + list.task_all;
				all_tasks_completed_progress = all_tasks_completed_progress + list.tasks_completed;

			    var row = new ListMilestoneRow (list);

		        milestone_list.add (row);

                row.selected_list.connect (selected_list);
				row.update_list.connect ( () => {
					update_list ();
					list_selected (list);
				});


            }

			all_tasks_completed_progress = 0;
			all_tasks_progress = 0;

			show_all ();
        }

        public void update_list () {
            foreach (Gtk.Widget element in milestone_list.get_children ()) {
                milestone_list.remove (element);
            }
            create_list ();
			update_alert ();
	   }

        private void selected_list (Interfaces.List list) {
            list_selected (list);
        }

		public void open_create_list () {
			Timeout.add (500, () => {
				new_list_popover.show_all ();
				return false;
			});
		}
    }
}
