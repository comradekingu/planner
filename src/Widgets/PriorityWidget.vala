namespace Planner {

	public class PriorityWidget : Gtk.Grid {

		private string title;

		private Gtk.Label title_label;
		private Gtk.Image icon_image;

		public PriorityWidget (string title_widget = "", string type_widget = "None") {

			title = title_widget;

			orientation = Gtk.Orientation.HORIZONTAL;
			column_homogeneous = true;
			get_style_context ().add_class (type_widget);	

			build_ui ();
		}

		private void build_ui () {

			icon_image = new Gtk.Image.from_icon_name ("emblem-important-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
			
			title_label = new Gtk.Label ("<b>" + title + "</b>");
			title_label.use_markup = true;

			add (icon_image);
			add (title_label);
		}
	}
}