namespace Planner {
    public class FormatBar : Gtk.Grid {
        private FormatButton overview_toggle;
        private FormatButton task_toggle;
        private FormatButton issues_toggle;

        private Granite.Widgets.ModeButton main;

        public signal void on_formarbar_select (int index_bar);

        private const string CSS = """
                .format-bar {
                    background-color: @bg_color;
                    border-radius: 3px;
                }
            """;

        static construct {
            var provider = new Gtk.CssProvider ();
            try {
                provider.load_from_data (CSS, CSS.length);
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (Error e) {
                critical (e.message);
            }
        }

        construct {
            var style_context = get_style_context ();
            style_context.add_class ("format-bar");
            style_context.add_class (Gtk.STYLE_CLASS_LINKED);

            overview_toggle = new FormatButton ();
            overview_toggle.icon = new ThemedIcon ("office-calendar-symbolic");
            overview_toggle.text = _("Overview");

            task_toggle = new FormatButton ();
            task_toggle.icon = new ThemedIcon ("emblem-default-symbolic");
            task_toggle.text = _("Tasks");

            issues_toggle = new FormatButton ();
            issues_toggle.icon = new ThemedIcon ("emblem-important-symbolic");
            issues_toggle.text = _("Issues");

            main = new Granite.Widgets.ModeButton ();
            main.append (overview_toggle);
            main.append (task_toggle);
            //main.append (issues_toggle);
            main.selected = 0;
            main.mode_changed.connect ( (widget) => {
                on_formarbar_select (main.selected);
            });

            add (main);
        }

        public void set_item_index (int index) {
            main.selected = index;
        }

    }

    public class FormatButton : Gtk.Box {
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
