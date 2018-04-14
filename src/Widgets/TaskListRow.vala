namespace Planner {

	public class TaskListRow : Gtk.Grid {
		
		private Gtk.Label title_label;
		private Gtk.Button deadline_button;
		private Gtk.CheckButton state_button;
		private Gtk.ComboBoxText priority_comboboxtext;
		private Granite.Widgets.DatePicker deadline_picker;
		private Gtk.Button remove_button;
	
		private Gtk.TextView note_view;
		private Gtk.Revealer revealer_noteview;
		private PriorityWidget priority_view;

		private Gtk.Box main_box;
		private string old_label = "";
		private Interfaces.Task task_actual;

		private Gdk.Cursor cursor;

		public signal void update_task (Interfaces.Task task);

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

			cursor = new Gdk.Cursor.for_display (Gdk.Display.get_default (), Gdk.CursorType.CROSSHAIR);

			state_button = new Gtk.CheckButton ();																			
			state_button.active = bool.parse (task_actual.state);
			state_button.halign = Gtk.Align.START;

			title_label = new Gtk.Label (task_actual.name);
			title_label.use_markup = true;
			title_label.margin_left = 12;
			title_label.halign = Gtk.Align.START;
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			remove_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
			remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			remove_button.halign = Gtk.Align.END;
			remove_button.no_show_all = true;
			remove_button.tooltip_text = _("Remove Task");

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			box.pack_start (title_label, true, true, 0);
			box.pack_end (remove_button, false, false, 0);

			var option_event = new Gtk.EventBox();
			option_event.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
			option_event.add (box);

			// Event Signals
			option_event.button_press_event.connect (show_options);
			option_event.enter_notify_event.connect ( (event) => {
                remove_button.visible = true;
                return false;
            });

			option_event.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }
                remove_button.visible = false;
                return false;
			});
			
			var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);

			note_view = new Gtk.TextView ();
			note_view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
			note_view.expand = true;

			var scrolled = new Gtk.ScrolledWindow (null, null);
			scrolled.hexpand = true;
			scrolled.height_request = 150;
			scrolled.margin_left = 32;
			scrolled.margin_top = 12;
			scrolled.margin_bottom = 12;
			scrolled.add (note_view);

			var horizontal_grid = new Gtk.Grid ();
			horizontal_grid.expand = true;
			horizontal_grid.orientation = Gtk.Orientation.HORIZONTAL;
			horizontal_grid.column_spacing = 24;

			var task_option_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

			priority_view = new PriorityWidget ("None", "None");

			priority_comboboxtext = new Gtk.ComboBoxText ();
			priority_comboboxtext.append_text (_("None"));
			priority_comboboxtext.append_text (_("Low"));
			priority_comboboxtext.append_text (_("Medium"));
			priority_comboboxtext.append_text (_("High"));
			priority_comboboxtext.active = 0;

			deadline_picker = new Granite.Widgets.DatePicker ();

			task_option_box.pack_start (new Granite.HeaderLabel (_("Priority")), true, false, 0);
			task_option_box.pack_start (priority_comboboxtext, true, false, 0);
			task_option_box.pack_start (new Granite.HeaderLabel (_("Deadline")), true, false, 0);
			task_option_box.pack_start (deadline_picker, true, false, 0);
			//task_option_box.pack_start (remove_button, true, false, 12);

			horizontal_grid.add (scrolled);
			//horizontal_grid.add (task_option_box);

			revealer_noteview = new Gtk.Revealer();
			revealer_noteview.reveal_child = false;
			revealer_noteview.add (horizontal_grid);


			main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			main_box.expand = true; 
			main_box.valign = Gtk.Align.END;

			main_box.pack_start (state_button, false, false, 0);
			main_box.pack_start (option_event, true, true, 0);

			state_button.toggled.connect ( () => {

				task_actual.state = state_button.active.to_string ();
				update_task (task_actual);
			});

			add (separator);
			add (main_box);
			add (revealer_noteview);
		}

		private bool show_options (Gtk.Widget sender, Gdk.EventButton evt)
		{
			if (revealer_noteview.reveal_child) {

            	revealer_noteview.reveal_child = false;
            	main_box.margin_top = 0;

            	title_label.label = old_label;

            	priority_view.visible = true;

            } else {
	
                revealer_noteview.reveal_child = true;
                main_box.margin_top = 12;
                note_view.grab_focus ();

                old_label = title_label.label;
                title_label.label = "<b>" + title_label.label + "</b>";

                priority_view.visible = false;
            }

            return true;
		}	
	}
}