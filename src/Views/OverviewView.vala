namespace Planner {
	public class OverviewView : Gtk.EventBox {

		private Gtk.Image avatar_image;
		private Gtk.Label title_label;
		private Gtk.Label description_label;

		private Interfaces.Project project_actual;

		public OverviewView () {

			get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        	get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);

			build_ui ();
		}

		private void build_ui () {

			var main_grid  = new Gtk.Grid ();
			main_grid.orientation = Gtk.Orientation.VERTICAL;
			main_grid.row_spacing = 24;
			main_grid.margin = 50;
			main_grid.halign = Gtk.Align.CENTER;
			main_grid.expand = true;

			avatar_image = new Gtk.Image.from_icon_name ("com.github.alainm23.planner", Gtk.IconSize.DND);
			avatar_image.pixel_size = 96;
			//avatar_image.halign = Gtk.Align.CENTER;
			avatar_image.hexpand = true;

			title_label = new Gtk.Label ("<b>Planner</b>");
			title_label.use_markup = true;
			title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

			description_label = new Gtk.Label ("<b>elementary App</b>");
			description_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
			description_label.use_markup = true;

			main_grid.add (avatar_image);
			main_grid.add (title_label);
			main_grid.add (description_label);

			add (main_grid);
		}
	}
}
