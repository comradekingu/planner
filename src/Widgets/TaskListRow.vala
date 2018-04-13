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

			title_label = new Gtk.Label (task_actual.name);
			title_label.use_markup = true;
			title_label.margin_left = 12;
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			var label_event = new Gtk.EventBox();
			label_event.button_press_event.connect(show_options);
			label_event.add (title_label);

			state_button = new Gtk.CheckButton ();																			
			state_button.active = bool.parse (task_actual.state);
			state_button.halign = Gtk.Align.START;

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

			remove_button = new Gtk.Button.with_label (_("Delete"));
			remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

			task_option_box.pack_start (new Granite.HeaderLabel (_("Priority")), true, false, 0);
			task_option_box.pack_start (priority_comboboxtext, true, false, 0);
			task_option_box.pack_start (new Granite.HeaderLabel (_("Deadline")), true, false, 0);
			task_option_box.pack_start (deadline_picker, true, false, 0);
			task_option_box.pack_start (remove_button, true, false, 12);

			horizontal_grid.add (scrolled);
			//horizontal_grid.add (task_option_box);

			revealer_noteview = new Gtk.Revealer();
			revealer_noteview.reveal_child = false;
			revealer_noteview.add (horizontal_grid);


			main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			main_box.expand = true; 
			main_box.valign = Gtk.Align.END;

			main_box.pack_start (state_button, false, false, 0);
			main_box.pack_start (label_event, false, false, 0);
			//main_box.pack_end (priority_view, false, false, 0);

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