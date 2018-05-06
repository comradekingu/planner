namespace Planner {
	public class Views.OverviewView : Gtk.EventBox {
        public OverviewView () {
            var label = new Gtk.Label ("OverviewView");
            label.halign = Gtk.Align.CENTER;
            label.valign = Gtk.Align.CENTER;

            add (label);
        }
    }
}
