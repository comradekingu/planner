namespace Planner {
	public class TaskList : Gtk.Grid {

		private Gtk.Label title_list_label;
		private Gtk.Entry task_entry;
		private Gtk.Box box_title;
		private Gtk.Button add_button;
		private Gtk.Button edit_list_button;
		private NewEditListPopover edit_list_popover;
		private Granite.Widgets.AlertView alert;
		private Gtk.Grid task_container;
		private Gtk.ScrolledWindow task_scrolled_window;
		private Services.Database db;
		private string TITLE_NONE_LIST_ALERT;
		private string DESCRIPTION_NONE_LIST_ALERT;
		private string TITLE_NONE_SELECT_ALERT;
		private string DESCRIPTION_NONE_SELECTED_ALERT;
		private string TITLE_NONE_TASK_ALERT;
		private string DESCRIPTION_NONE_TASK_ALERT;
		private string TITLE_NONE_TASK_COMPLETED_ALERT;
		private string DESCRIPTION_NONE_TASK_COMPLETED_ALERT;

		private Interfaces.List list_actual;

		private Granite.Widgets.ModeButton task_state_modebutton;

		private bool filter_bool;
		private bool none_tasks_bool;
		private int count_task = 0;

		public signal void update_list_all ();

		public TaskList () {
			expand = true;
			orientation = Gtk.Orientation.VERTICAL;
            row_spacing = 12;
            margin = 25;
            margin_bottom = 50;
			width_request = 500;

			filter_bool = true;
			none_tasks_bool = false;

			TITLE_NONE_LIST_ALERT = _("No List");
			DESCRIPTION_NONE_LIST_ALERT = _("To start creating <b>Tasks</b> you must create a first <b>List</b>");

			TITLE_NONE_SELECT_ALERT = _("Select a List");
			DESCRIPTION_NONE_SELECTED_ALERT = _("Select a <b>List</b> to start viewing and completing <b>Tasks</b>");

			TITLE_NONE_TASK_ALERT = _("No homework");
			DESCRIPTION_NONE_TASK_ALERT = _("Create a <b>Task</b> with the <b>+</b> button");

			TITLE_NONE_TASK_COMPLETED_ALERT = _("No completed task");
			DESCRIPTION_NONE_TASK_COMPLETED_ALERT = _("Start to complete to fill this space");

			list_actual = new Interfaces.List ();

			db = new Services.Database (true);



			build_ui ();
		}

		private void build_ui () {
			alert = new Granite.Widgets.AlertView (TITLE_NONE_SELECT_ALERT, DESCRIPTION_NONE_SELECTED_ALERT, "dialog-warning");

			title_list_label = new Gtk.Label ("");
			title_list_label.use_markup = true;
			title_list_label.halign = Gtk.Align.START;
			title_list_label.margin_left = 6;
			title_list_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

			edit_list_button = new Gtk.Button.from_icon_name ("document-edit-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
			edit_list_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

			edit_list_popover = new NewEditListPopover (edit_list_button);
			edit_list_popover.update_list.connect ( (list) => {
				update_list_all ();

				list_actual = list;
				title_list_label.label = "<b>" + list_actual.name + "</b>";
			});
			edit_list_popover.remove_list.connect ( () => {
				update_list_all ();

				alert.visible = true;
				box_title.visible = false;
				task_scrolled_window.visible = false;
			});

			edit_list_button.clicked.connect ( () => {
				edit_list_popover.set_list_to_edit (list_actual);
 				edit_list_popover.show_all ();
			});

			task_state_modebutton = new Granite.Widgets.ModeButton ();
			task_state_modebutton.valign = Gtk.Align.CENTER;

			task_state_modebutton.append_text (_("Open"));
			task_state_modebutton.append_text (_("Completed"));
			task_state_modebutton.selected = 0;
			task_state_modebutton.mode_changed.connect ( (widget) => {

				if (task_state_modebutton.selected == 0) {
					filter_bool = true;
				} else {
					filter_bool = false;
				}

				update_list ();
			});

			add_button = new Gtk.Button.from_icon_name("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            add_button.tooltip_text = _("Create a new Task");
			add_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            add_button.halign = Gtk.Align.END;
			add_button.valign = Gtk.Align.CENTER;

			add_button.clicked.connect ( () => {
            	box_title.visible = false;
            	task_entry.visible = true;
            	task_entry.grab_focus ();
            	task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "close-symbolic");
            });

			box_title = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			box_title.margin_left = 6;
			box_title.hexpand = true;

			box_title.pack_start (title_list_label, false, false, 0);
			box_title.pack_start (edit_list_button, false, false, 0);

			box_title.pack_end (add_button, false, false, 6);
			box_title.pack_end (task_state_modebutton, false, false, 0);

			task_entry = new Gtk.Entry ();
			task_entry.set_icon_tooltip_text (Gtk.EntryIconPosition.SECONDARY, _("Add to list..."));
			task_entry.no_show_all = true;
			task_entry.max_length = 128;
			task_entry.margin_left = 12;
			task_entry.placeholder_text = _("Add new task...");
			task_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			task_entry.changed.connect( () => {
                if (task_entry.text == "") {
                    task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "close-symbolic");
                } else {
                    task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "list-add-symbolic");
                }
			});

			task_entry.activate.connect ( () => {
				add_task ();
			});

			task_entry.icon_press.connect ((pos, event) => {
				if (pos == Gtk.EntryIconPosition.SECONDARY) {
					if (task_entry.secondary_icon_name == "close-symbolic") {
						task_entry.visible = false;
						box_title.visible = true;
						task_entry.text = "";
					} else {
						add_task ();
					}
				}
			});

			task_entry.key_press_event.connect ( (key) => {
				if (key.keyval == Gdk.Key.Escape) {
					task_entry.visible = false;
					box_title.visible = true;
					task_entry.text = "";
				}
				return false;
			});

			task_container = new Gtk.Grid ();
			task_container.orientation = Gtk.Orientation.VERTICAL;

			task_scrolled_window = new Gtk.ScrolledWindow (null, null);
            task_scrolled_window.expand = true;
			task_scrolled_window.add (task_container);

			add (task_entry);
			add (box_title);
			add (task_scrolled_window);
			add (alert);

			box_title.no_show_all = true;
			task_scrolled_window.no_show_all = true;

			update_list ();
		}

		private void update_list () {
			foreach (Gtk.Widget element in task_container.get_children ()) {
				task_container.remove (element);
			}

			create_list ();
		}

		private void create_list () {
			var all_task = new Gee.ArrayList<Interfaces.Task?> ();
			all_task = db.get_all_tasks (list_actual.id);

			count_task = 0;

			foreach (var task in all_task) {
				if (bool.parse(task.state) != filter_bool) {

					var row = new TaskListRow (task);

					task_container.add (row);
					connect_row_signals (row);

					count_task = count_task + 1;
				}
			}

			var last_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
			last_separator.margin_left = 12;
			task_container.add (last_separator);

			update_alert ();

			show_all ();
		}

		private void connect_row_signals (TaskListRow row) {
			row.update_signal.connect (update_task);
		}

		private void update_task () {
			update_list_all ();
		}

		private void add_task () {
			var task = new Interfaces.Task ();

            task.name = task_entry.text;
            task.state = "false";
            task.deadline = "";
            task.note = "";
            task.id_list = list_actual.id;

			if (task_entry.text != "") {
				db.add_task (task);
				task_entry.visible = false;
				box_title.visible = true;
				task_entry.text = "";

				update_list_all ();
				update_list ();
			}
		}

		public void set_list (Interfaces.List list) {
			list_actual = list;

			update_list ();

			title_list_label.label = "<b>"+ list_actual.name +"</b>";
			edit_list_popover.set_list_to_edit (list_actual);

			box_title.no_show_all = false;
			task_scrolled_window.no_show_all = false;

			show_all ();
			alert.visible = false;
		}

		public void update_alert () {
			if (db.get_list_length () < 1) {
				alert.title = TITLE_NONE_LIST_ALERT;
				alert.description = DESCRIPTION_NONE_LIST_ALERT;
			} else if (list_actual.name == "") {
				alert.title = TITLE_NONE_SELECT_ALERT;
				alert.description = DESCRIPTION_NONE_SELECTED_ALERT;
			} else {
				alert.no_show_all = true;
				alert.visible = false;
			}
		}

		public void no_select_list () {
			alert.visible = true;
			box_title.visible = false;
			task_scrolled_window.visible = false;
		}
	}
}
