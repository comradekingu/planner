namespace Planner {
    public class Widgets.WorkList : Gtk.Grid {
        public signal void on_selected_signal (int index);
        public WorkList () {
            orientation = Gtk.Orientation.VERTICAL;
            row_spacing = 6;

            build_ui ();
        }

        private void build_ui () {
            var tasks_item = new Widgets.Item (_("Task"), "emblem-default", 12);
            var today_item = new Widgets.Item (_("Today"), "planner-star", 5);

            today_item.on_selected.connect ( () => {
                tasks_item.color_label.opacity = 0;
                on_selected_signal (0);
            });

            tasks_item.on_selected.connect ( () => {
                today_item.color_label.opacity = 0;
                on_selected_signal (1);
            });

            var milestones_label = new Granite.HeaderLabel (_("Milestones"));
            milestones_label.margin_left = 18;

            today_item.color_label.opacity = 1;

            add (today_item);
            add (tasks_item);
            add (milestones_label);
        }
    }

    public class Widgets.Item : Gtk.EventBox {
        public signal void on_selected ();
        public Gtk.Label color_label;
        public Item (string name, string icon, int tasks) {
            hexpand = true;
            add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);

            color_label = new Gtk.Label (null);
            color_label.width_request = 4;
            color_label.get_style_context ().add_class ("color_menu");
            color_label.opacity = 0;

            var avatar_image = new Gtk.Image.from_icon_name (icon, Gtk.IconSize.DND);
            var name_label = new Gtk.Label (name);
            //var label = new Gtk.Label (name);
            name_label.get_style_context ().add_class ("h3");
            name_label.use_markup = true;

            var tasks_label = new Gtk.Label (tasks.to_string ());
            tasks_label.valign = Gtk.Align.CENTER;
            tasks_label.margin_end = 12;
            tasks_label.get_style_context ().add_class ("h3");

            this.enter_notify_event.connect ( (event) => {
                // True
                get_style_context ().add_class ("color_item");
                return false;
            });

            this.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }
                // False
                get_style_context ().remove_class ("color_item");
                return false;
            });

            this.button_press_event.connect ( () => {
                color_label.opacity = 1;
                on_selected ();
                return false;
            });

            box.pack_start (color_label, false, true, 0);
            box.pack_start (avatar_image, false, false, 6);
            box.pack_start (name_label, false, false, 0);
            box.pack_end (tasks_label, false, true, 0);

            add (box);
        }
    }
}
