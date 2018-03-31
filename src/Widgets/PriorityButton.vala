namespace Planner {

	public class PriorityButton : Gtk.Button {

		private string title;

		private Gtk.Label title_label;
		private Gtk.Image icon_image;

		private PriorityButton priority_popover;

		public PriorityButton (string title_button = "") {

			title = title_button;

			get_style_context ().add_class (title);	
			set_focus_on_click (false);

			build_ui ();
		}

		private void build_ui () {

			icon_image = new Gtk.Image.from_icon_name ("spam-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
			
			title_label = new Gtk.Label ("<b>" + title + "</b>");
			title_label.use_markup = true;

			add (icon_image);
			add (title_label);
		}
	}

	public class PriorityPopover : Gtk.Popover {

		PriorityButton low_button;
		PriorityButton medium_button;
		PriorityButton high_button;

		public PriorityPopover (Gtk.Widget relative) {

			GLib.Object (

                modal: true,
                position: Gtk.PositionType.BOTTOM,
                relative_to: relative

            );
		}

		construct {

			var main_grid = new Gtk.Grid ();
			main_grid.margin = 12;
			main_grid.orientation = Gtk.Orientation.VERTICAL;

			low_button = new PriorityButton ("Low");
			medium_button = new PriorityButton ("Medium");
			high_button = new PriorityButton ("High");

			main_grid.add (low_button);
			main_grid.add (medium_button);
			main_grid.add (high_button);
		}
	}
}