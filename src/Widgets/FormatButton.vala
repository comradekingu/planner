namespace Planner {
    public class Widgets.FormatButton : Gtk.Box {
        public unowned string text {
            set {
                label_widget.label = value;
            }

            get {
                return label_widget.get_label ();
            }
        }

        public unowned GLib.Icon? icon {
            owned get {
                return img.gicon;
            }
            set {
                img.gicon = value;
            }
        }

        private Gtk.Image img;
        private Gtk.Label label_widget;

        construct {
            can_focus = false;
            width_request = 120;

            img = new Gtk.Image ();
            img.halign = Gtk.Align.END;
            img.icon_size = Gtk.IconSize.BUTTON;

            label_widget = new Gtk.Label (null);
            label_widget.halign = Gtk.Align.START;

            pack_start (img, true, true, 0);
            pack_start (label_widget, true, true, 0);
        }
    }
}
