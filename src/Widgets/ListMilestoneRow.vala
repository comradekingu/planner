namespace Planner {
	public class ListMilestoneRow : Gtk.Button {

		private Gtk.Image state_image;
		private Gtk.Label name_label;
		private Gtk.Label state_label;
		private Gtk.Image avatar_image;

		private Interfaces.List actual_list;

		public signal void selected_list (Interfaces.List list);

		public ListMilestoneRow (Interfaces.List list) {

			actual_list = list;

			get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			height_request = 50;
			expand = true;

			build_ui ();
		}

		private void build_ui () {

			avatar_image = new Gtk.Image.from_icon_name (actual_list.icon, Gtk.IconSize.LARGE_TOOLBAR);
			avatar_image.vexpand = true;

			name_label = new Gtk.Label ("<b>" + actual_list.name + "</b>");
			name_label.use_markup = true;
			name_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			state_label = new Gtk.Label (actual_list.tasks_completed.to_string () + "/" + actual_list.task_all.to_string ());
			state_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
			state_label.vexpand = true;
			state_label.use_markup = true;

			state_image = new Gtk.Image.from_icon_name("user-idle", Gtk.IconSize.SMALL_TOOLBAR);
			state_label.vexpand = true;

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
			box.expand = true;

			var grid = new Gtk.Grid ();
			grid.orientation = Gtk.Orientation.HORIZONTAL;

			box.pack_start (avatar_image, false, true, 6);
			box.pack_start (name_label, false, true, 6);
			box.pack_end (state_image, false, true, 6);
			box.pack_end (state_label, false, true, 6);

			grid.attach (box, 0, 0, 1, 1);

			this.clicked.connect ( () => {

				selected_list (actual_list);

			});

			add (grid);
		}

		public Interfaces.List get_list () {

			return actual_list;

		}
	}
}
