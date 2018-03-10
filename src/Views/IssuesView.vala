namespace Planner {
	public class IssuesView : Gtk.Grid {

		Gtk.Label label;

		public IssuesView () {

			valign = Gtk.Align.CENTER;
	        halign = Gtk.Align.CENTER;

			build_ui ();
		}

		private void build_ui () {

			label = new Gtk.Label ("Issues");
			
			add (label);
		}

		public void text (string text) {
			label.set_text (text);
		}
	}
}