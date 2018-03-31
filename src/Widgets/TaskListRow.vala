namespace Planner {

	public class TaskListRow : Gtk.Grid {
		
		private Gtk.Label title_label;
		private Gtk.Button deadline_button;
		private Gtk.CheckButton state_button;

		private Gtk.TextView note_view;
		private Gtk.Revealer revealer_noteview;
		private PriorityButton priority_button;
		private PriorityPopover priority_popover;


		private Gtk.Box main_box;

		public TaskListRow () {

			orientation = Gtk.Orientation.VERTICAL;
			height_request = 50;
			margin_left = 12;
			hexpand = true;
			vexpand = false;

			build_ui ();
		}

		private void build_ui () {

			title_label = new Gtk.Label ("Make a Wireframe");
			title_label.use_markup = true;
			title_label.margin_left = 12;
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			var label_event = new Gtk.EventBox();
			label_event.button_press_event.connect(show_options);
			label_event.add (title_label);

			state_button = new Gtk.CheckButton ();
			state_button.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);																					
			//state_button.expand = true;
			state_button.halign = Gtk.Align.START;

			var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);

			note_view = new Gtk.TextView ();
			note_view.set_wrap_mode (Gtk.WrapMode.WORD);
			note_view.expand = true;

			var scrolled = new Gtk.ScrolledWindow (null, null);
			//scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
			scrolled.hexpand = true;
			scrolled.height_request = 150;
			scrolled.margin_left = 32;
			scrolled.margin_top = 12;
			scrolled.margin_bottom = 12;
			scrolled.add (note_view);

			revealer_noteview = new Gtk.Revealer();
			revealer_noteview.reveal_child = false;
			//revealer_noteview.transition_duration = 500;
			revealer_noteview.add (scrolled);

			priority_button = new PriorityButton ("High");
			priority_popover = new PriorityPopover (priority_button);

			priority_button.clicked.connect ( () => {

				priority_popover.show_all ();
				
			});


			main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
			main_box.expand = true; 
			main_box.valign = Gtk.Align.END;

			main_box.pack_start (state_button, false, false, 0);
			main_box.pack_start (label_event, false, false, 0);

			main_box.pack_end (priority_button, false, false, 0);

			add (separator);
			add (main_box);
			add (revealer_noteview);
		}

		private bool show_options (Gtk.Widget sender, Gdk.EventButton evt)
		{
			if (revealer_noteview.reveal_child) {

            	revealer_noteview.reveal_child = false;
            	main_box.margin_top = 0;
            	priority_button.visible = true;

            } else {
	
                revealer_noteview.reveal_child = true;

                priority_button.visible = false;
                main_box.margin_top = 12;

                note_view.grab_focus ();
            }

            return true;
		}	
	}
}