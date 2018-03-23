namespace Planner {
	public class OverviewView : Gtk.EventBox {

		public OverviewView () {

			get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        	get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);

			build_ui ();
		}

		private void build_ui () {


		}

	}
}