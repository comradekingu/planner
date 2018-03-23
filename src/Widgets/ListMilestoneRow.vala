namespace Planner {

	public class ListMilestoneRow : Gtk.Button {

		private Gtk.Image state_image;
		private Gtk.Label name_label;
		private Gtk.Label state_label;

		public ListMilestoneRow () {

			get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			height_request = 50;

			build_ui ();
		}

		private void build_ui () {

			

			name_label = new Gtk.Label ("<b>Designe</b>");
			name_label.use_markup = true;
			name_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			state_label = new Gtk.Label ("<b>4/10</b>");
			state_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
			state_label.vexpand = true;
			state_label.use_markup = true;

			state_image = new Gtk.Image.from_icon_name("user-idle", Gtk.IconSize.SMALL_TOOLBAR);
			state_label.vexpand = true;

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
			box.hexpand = true;

			var grid = new Gtk.Grid ();
			grid.orientation = Gtk.Orientation.HORIZONTAL;

			box.pack_start (name_label, false, true, 6);
			box.pack_end (state_image, false, true, 6);
			box.pack_end (state_label, false, true, 6);

			grid.attach (box, 0, 0, 1, 1);
			//grid.attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 1, 1, 1);
			
			add (grid);
		}

	}
}