namespace Planner {
	public class TaskListRow : Gtk.Revealer {
		Gtk.CheckButton state_button;
		private Gtk.Label title_label;

		private Gtk.Button remove_button;
		private Gtk.Button edit_button;
		private Gtk.Button tag_new_button;
		private Gtk.Button calendar_button;

		private Gtk.TextView note_view;
		private Gtk.Revealer revealer_noteview;
		private Gtk.Entry task_entry;
		private Gtk.Box main_box;
		public Interfaces.Task task_actual;

		private bool edit_bool = false;

		public signal void update_signal ();

		private Services.Database db;

		public TaskListRow (Interfaces.Task task) {
			reveal_child = true;
			transition_type = Gtk.RevealerTransitionType.SLIDE_UP;
			transition_duration = 500;
			height_request = 35;
			margin_left = 6;
			hexpand = true;
			vexpand = false;
			task_actual = task;
			tooltip_text = task_actual.name;

			db = new Services.Database (true);

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
			title_label.ellipsize = Pango.EllipsizeMode.END;
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			task_entry = new Gtk.Entry ();
			task_entry.no_show_all = true;
			task_entry.max_length = 128;
			task_entry.margin_left = 12;
			task_entry.placeholder_text = _("Task name");
			task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "close-symbolic");
			task_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			task_entry.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			edit_button = new Gtk.Button.from_icon_name ("document-edit", Gtk.IconSize.MENU);
			edit_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			edit_button.halign = Gtk.Align.END;
			edit_button.tooltip_text = _("Edit Task");

			remove_button = new Gtk.Button.from_icon_name ("edit-delete", Gtk.IconSize.MENU);
			remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			remove_button.halign = Gtk.Align.END;
			remove_button.tooltip_text = _("Remove Task");

			tag_new_button = new Gtk.Button.from_icon_name ("tag-new", Gtk.IconSize.MENU);
			tag_new_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			tag_new_button.tooltip_text = _("Add Tags");

			calendar_button = new Gtk.Button.from_icon_name ("office-calendar", Gtk.IconSize.MENU);
			calendar_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			calendar_button.tooltip_text = _("Add Duedate");

			var option_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
			option_box.halign = Gtk.Align.END;

			option_box.pack_start (calendar_button, false, false, 0);
			option_box.pack_start (tag_new_button, false, false, 0);
			option_box.pack_start (edit_button, false, false, 0);
			option_box.pack_start (remove_button, false, false, 0);

			var image_button = new Gtk.Image.from_icon_name("pan-down-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

			var show_option_button = new Gtk.Button ();
			show_option_button.image = image_button;
			show_option_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

			var action_grid = new Gtk.Grid ();
			action_grid.add (show_option_button);
			//action_grid.add (remove_button);

			var action_revealer = new Gtk.Revealer ();
            action_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT;
            action_revealer.add (action_grid);
            action_revealer.show_all ();
            action_revealer.reveal_child = false;

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			box.pack_start (title_label, true, true, 0);
			box.pack_start (task_entry, true, true, 0);
			box.pack_end (action_revealer, false, false, 0);

			var option_event = new Gtk.EventBox ();
			option_event.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
			option_event.add (box);

			note_view = new Gtk.TextView ();
			note_view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
			note_view.expand = true;
			note_view.buffer.text = task_actual.note;

			var tabs = new Pango.TabArray (8, true);
			tabs.set_tab(8, Pango.TabAlign.LEFT, 8);

			note_view.set_tabs (tabs);
			note_view.get_style_context ().add_class ("textview");

			note_view.buffer.changed.connect ( () => {
				task_actual.note = note_view.buffer.text;

				Thread<void*> thread = new Thread<void*>.try("Update note", () => {
					db.update_task (task_actual);
					return null;
				});
			});
			note_view.key_press_event.connect ( (key) => {
				if (key.keyval == Gdk.Key.Escape) {
					revealer_noteview.reveal_child = false;
				}
				return false;
			});

			var scrolled = new Gtk.ScrolledWindow (null, null);
			scrolled.hexpand = true;
			scrolled.height_request = 100;
			scrolled.margin_left = 32;
			scrolled.margin_top = 6;
			scrolled.margin_bottom = 12;
			scrolled.add (note_view);

			var grid = new Gtk.Grid ();
			grid.orientation = Gtk.Orientation.VERTICAL;

			grid.add (scrolled);
			grid.add (option_box);

			revealer_noteview = new Gtk.Revealer();
			revealer_noteview.reveal_child = false;
			revealer_noteview.visible = false;
			revealer_noteview.transition_duration = 500;
			revealer_noteview.add (grid);

			main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			main_box.expand = true;
			main_box.valign = Gtk.Align.END;

			main_box.pack_start (state_button, false, false, 0);
			main_box.pack_start (option_event, true, true, 0);

			var g = new Gtk.Grid ();
			g.orientation = Gtk.Orientation.VERTICAL;

			g.add (main_box);
			g.add (revealer_noteview);

			add (g);
			//add (revealer_noteview);

			// Event Signals
			show_option_button.clicked.connect ( () => {
				if (revealer_noteview.reveal_child) {
					image_button.icon_name = "pan-down-symbolic";
					show_option_button.image = image_button;

					revealer_noteview.reveal_child = false;
				} else {
					image_button.icon_name = "pan-up-symbolic";
					show_option_button.image = image_button;

					revealer_noteview.reveal_child = true;
					note_view.grab_focus ();
				}
			});

			option_event.button_press_event.connect (show_options);
			option_event.enter_notify_event.connect ( (event) => {

				if (edit_bool != true) {
					action_revealer.reveal_child = true;
					title_label.get_style_context ().add_class ("label_link");
				}

				return false;
			});

			option_event.leave_notify_event.connect ((event) => {
				if (event.detail == Gdk.NotifyType.INFERIOR) {
					return false;
				}
				title_label.get_style_context ().remove_class ("label_link");
				action_revealer.reveal_child = false;

				return false;
			});

			state_button.toggled.connect ( () => {

				task_actual.state = state_button.active.to_string ();
				db.update_task (task_actual);

				//visible = false;
				/* Test Notification
				Timeout.add_seconds (4, () => {

					var notification = new GLib.Notification ("");
					notification.set_title ("Hey Alain, " + task_actual.name + " was completed");
					notification.set_body ("Quieres hacer algo?");
					notification.set_priority (GLib.NotificationPriority.URGENT);
					var image = new Gtk.Image.from_icon_name ("com.github.alainm23.planner", Gtk.IconSize.DIALOG);
					notification.set_icon (image.gicon);
					notification.add_button ("Button 1", "Button 1");

					GLib.Application.get_default ().send_notification ("com.github.alainm23.planner", notification);

					return true;
				});
				*/
				update_signal ();
			});

			remove_button.clicked.connect ( () => {
				db.remove_task (task_actual);
				update_signal ();
				revealer_noteview.reveal_child = false;
				Timeout.add (400, () => {
					reveal_child = false;
					destroy ();
					return false;
				});
			});

			edit_button.clicked.connect ( () => {

				edit_bool = true;
				action_revealer.reveal_child = false;
				revealer_noteview.reveal_child = false;
				main_box.margin_top = 0;

				task_entry.visible = true;
				title_label.visible = false;
				task_entry.text = title_label.label;

				task_entry.grab_focus ();
			});

			task_entry.activate.connect ( () => {
				task_actual.name = task_entry.text;
				title_label.label = task_actual.name;

				db.update_task (task_actual);

				title_label.visible = true;
				task_entry.visible = false;

				edit_bool = false;
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

	   		} else {
				if (edit_bool) {

				} else {
					revealer_noteview.reveal_child = true;
					note_view.grab_focus ();
				}
	       	}

	       	return true;
		}
	}
}
