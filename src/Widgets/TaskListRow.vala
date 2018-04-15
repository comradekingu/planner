namespace Planner {
	public class TaskListRow : Gtk.Grid {

		Gtk.CheckButton state_button;
		private Gtk.Label title_label;
		private Gtk.Button deadline_button;
		private Gtk.Button remove_button;
		private Gtk.Button edit_button;
		private Gtk.TextView note_view;
		private Gtk.Revealer revealer_noteview;
		private Gtk.Entry task_entry;

		private Gtk.Box main_box;
		private string old_label = "";
		private Interfaces.Task task_actual;

		private bool edit_bool = false;

		public signal void update_task (Interfaces.Task task);
		public signal void remove_task (Interfaces.Task task);

		public TaskListRow (Interfaces.Task task) {

			orientation = Gtk.Orientation.VERTICAL;
			height_request = 50;
			margin_left = 12;
			hexpand = true;
			vexpand = false;
			task_actual = task;

			build_ui ();
		}

		private void build_ui () {

			state_button = new Gtk.CheckButton ();
			state_button.active = bool.parse (task_actual.state);
			state_button.halign = Gtk.Align.START;

			title_label = new Gtk.Label (task_actual.name);
			title_label.use_markup = true;
			title_label.margin_left = 12;
			title_label.halign = Gtk.Align.START;
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			task_entry = new Gtk.Entry ();
			task_entry.no_show_all = true;
			task_entry.max_length = 128;
			task_entry.margin_left = 12;
			task_entry.placeholder_text = _("Task name");
			task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "close-symbolic");
			task_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			task_entry.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			edit_button = new Gtk.Button.from_icon_name ("document-edit-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
			edit_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			edit_button.halign = Gtk.Align.END;
			edit_button.tooltip_text = _("Edit Task");

			remove_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
			remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			remove_button.halign = Gtk.Align.END;
			remove_button.tooltip_text = _("Remove Task");

			var action_grid = new Gtk.Grid ();
			action_grid.add (edit_button);
			action_grid.add (remove_button);

			var action_revealer = new Gtk.Revealer ();
            action_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT;
            action_revealer.add (action_grid);
            action_revealer.show_all ();
            action_revealer.reveal_child = false;

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			box.pack_start (title_label, true, true, 0);
			box.pack_start (task_entry, true, true, 0);
			box.pack_end (action_revealer, false, false, 0);

			var option_event = new Gtk.EventBox();
			option_event.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
			option_event.add (box);

			note_view = new Gtk.TextView ();
			note_view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
			note_view.expand = true;
			note_view.buffer.text = task_actual.note;

			var scrolled = new Gtk.ScrolledWindow (null, null);
			scrolled.hexpand = true;
			scrolled.height_request = 150;
			scrolled.margin_left = 32;
			scrolled.margin_top = 12;
			scrolled.margin_bottom = 12;
			scrolled.add (note_view);

			revealer_noteview = new Gtk.Revealer();
			revealer_noteview.reveal_child = false;
			revealer_noteview.visible = false;
			revealer_noteview.add (scrolled);

			main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			main_box.expand = true;
			main_box.valign = Gtk.Align.END;

			main_box.pack_start (state_button, false, false, 0);
			main_box.pack_start (option_event, true, true, 0);

			add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
			add (main_box);
			add (revealer_noteview);

			// Event Signals
			option_event.button_press_event.connect (show_options);
			option_event.enter_notify_event.connect ( (event) => {

				if (edit_bool != true) {
					action_revealer.reveal_child = true;
				}

				return false;
			});

			option_event.leave_notify_event.connect ((event) => {
				if (event.detail == Gdk.NotifyType.INFERIOR) {
					return false;
				   }

				   action_revealer.reveal_child = false;

				return false;
			});

			note_view.buffer.changed.connect ( () => {

				task_actual.note = note_view.buffer.text;

			});

			state_button.toggled.connect ( () => {

				task_actual.state = state_button.active.to_string ();

				/*
				Timeout.add_seconds (1, () => {

					return false;
				});
				*/
				update_task (task_actual);
			});

			remove_button.clicked.connect ( () => {

				remove_task (task_actual);
			});

			edit_button.clicked.connect ( () => {

				edit_bool = true;
				action_revealer.reveal_child = false;

				task_entry.visible = true;
				title_label.visible = false;

				task_entry.grab_focus ();

			});

			task_entry.activate.connect ( () => {

				 task_actual.name = task_entry.text;
				 update_task (task_actual);
			});

			task_entry.icon_press.connect ((pos, event) => {

				if (pos == Gtk.EntryIconPosition.SECONDARY) {

					edit_bool = false;

					task_entry.visible = false;
					title_label.visible = true;

				}
			});

			task_entry.key_press_event.connect ( (key) => {

				if (key.keyval == Gdk.Key.Escape) {

					edit_bool = false;

					task_entry.visible = false;
					title_label.visible = true;

					task_entry.text = "";
				}

				return false;
			});
		}

		private bool show_options (Gtk.Widget sender, Gdk.EventButton evt) {
			if (revealer_noteview.reveal_child) {

	       		revealer_noteview.reveal_child = false;
	       		main_box.margin_top = 0;
	       		title_label.label = old_label;

				update_task (task_actual);

	   		} else {

				revealer_noteview.reveal_child = true;
	            main_box.margin_top = 12;
	            note_view.grab_focus ();

	            old_label = title_label.label;
	            title_label.label = "<b>" + title_label.label + "</b>";
	       	}

	       	return true;
		}
	}
}
