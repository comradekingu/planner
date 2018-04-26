namespace Planner {
	public class ListMilestoneRow : Gtk.Button { //Gtk.EventBox
		private Gtk.Image state_image;
		private Gtk.Label color_label;
		private Gtk.Label name_label;
		private Gtk.Label state_label;
		private Gtk.Image avatar_image;
		private NewEditListPopover edit_list_popover;
		private Gtk.EventBox main_eventbox;
		private Interfaces.List actual_list;

		public signal void selected_list (Interfaces.List list);
		public signal void update_list ();

		public ListMilestoneRow (Interfaces.List list) {
			actual_list = list;
			tooltip_text = actual_list.name;
			get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

			height_request = 40;
			expand = true;

			build_ui ();
		}

		private void build_ui () {
			main_eventbox = new Gtk.EventBox ();
			main_eventbox.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);

			color_label = new Gtk.Label ("");
			color_label.width_request = 3;
			color_label.get_style_context ().add_class ("color_label");
			color_label.no_show_all = true;

			avatar_image = new Gtk.Image.from_icon_name (actual_list.icon, Gtk.IconSize.DND);
			avatar_image.vexpand = true;

			//"<b>" + actual_list.name + "</b>"
			name_label = new Gtk.Label ("<b>%s</b>".printf(actual_list.name));
			name_label.use_markup = true;
			name_label.ellipsize = Pango.EllipsizeMode.END;
			name_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			state_label = new Gtk.Label ("%i".printf (actual_list.task_all - actual_list.tasks_completed));
			state_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
			state_label.get_style_context ().add_class ("badge");
			state_label.valign = Gtk.Align.CENTER;
			state_label.vexpand = true;
			state_label.use_markup = true;

			state_image = new Gtk.Image.from_icon_name("", Gtk.IconSize.SMALL_TOOLBAR);
			state_label.vexpand = true;

			if (actual_list.tasks_completed == 0) {
				state_image.icon_name = "user-offline";
			} else if (actual_list.tasks_completed ==  actual_list.task_all) {
				state_image.icon_name = "user-available";
			} else if (actual_list.tasks_completed > actual_list.task_all / 2) {
				state_image.icon_name = "user-idle";
			} else {
				state_image.icon_name = "user-busy";
			}

			edit_list_popover = new NewEditListPopover (this);
			edit_list_popover.update_list.connect ( (list) => {
				update_list ();
			});

			this.button_press_event.connect ( (event) => {
				if (event.type == Gdk.EventType.DOUBLE_BUTTON_PRESS) {
					edit_list_popover.set_list_to_edit (actual_list);
					edit_list_popover.show_all ();
				} else if (event.type == Gdk.EventType.BUTTON_PRESS) {
					selected_list (actual_list);

				}
				return false;
			});

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 3);
			box.expand = true;

			box.pack_start (color_label, false, false, 3);
			box.pack_start (avatar_image, false, false, 3);
			box.pack_start (name_label, false, false, 3);
			//box.pack_end (state_image, false, false, 3);
			box.pack_end (state_label, false, false, 3);

			main_eventbox.add (box);
			add (main_eventbox);
		}

		public Interfaces.List get_list () {
			return actual_list;
		}
	}
}
