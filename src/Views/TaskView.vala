namespace Planner {
	public class TaskView : Gtk.Grid {

		Gtk.Label label;

		public TaskView () {

			valign = Gtk.Align.CENTER;
	        halign = Gtk.Align.CENTER;

			build_ui ();
		}

		private void build_ui () {

			label = new Gtk.Label ("Task");
			
			add (label);
		}

		public void text (string text) {
			label.set_text (text);
		}
	}
}