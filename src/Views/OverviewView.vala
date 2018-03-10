namespace Planner {
	public class OverviewView : Gtk.Grid {

		Gtk.Label label;

		public OverviewView () {

			valign = Gtk.Align.CENTER;
	        halign = Gtk.Align.CENTER;

			build_ui ();
		}

		private void build_ui () {

			label = new Gtk.Label ("Overview");
			
			add (label);
		}

		public void text (string text) {
			label.set_text (text);
		}
	}
}