namespace Planner {
    public class ListProgress :  Gtk.Grid {
        private Gtk.Label title_label;
        private Gtk.ListBox progress_litbox;
        private Gtk.ScrolledWindow list_scrolled_window;
        private Granite.Widgets.AlertView alert;
        private Gtk.Label add_list_button;

        private Services.Database db;
		private GLib.Settings settings;

        public signal void add_list_signal ();

        public ListProgress () {
            orientation = Gtk.Orientation.VERTICAL;
            margin_right = 48;
            margin_bottom = 24;

            db = new Services.Database (true);
			settings = new GLib.Settings ("com.github.alainm23.planner");

            build_ui ();
        }

        private void build_ui () {
            alert = new Granite.Widgets.AlertView (_("No list"), _("Create a list to fill this space"), "dialog-warning");
            alert.show_action (_("Create list"));
            alert.no_show_all = true;

            alert.action_activated.connect ( () => {
                add_list_signal ();
            });

            title_label = new Gtk.Label (_("<b>Progress</b>"));
            title_label.use_markup = true;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.halign = Gtk.Align.START;

            progress_litbox = new Gtk.ListBox ();
            progress_litbox.selection_mode = Gtk.SelectionMode.NONE;
            progress_litbox.expand = true;

            list_scrolled_window = new Gtk.ScrolledWindow (null, null);
            list_scrolled_window.expand = true;
            list_scrolled_window.add (progress_litbox);


            add_list_button = new Gtk.Label (_("New list"));
            add_list_button.tooltip_text = _("Create a new list");
            add_list_button.halign = Gtk.Align.END;
            add_list_button.get_style_context ().add_class ("label_link");



            var option_event = new Gtk.EventBox ();
            option_event.add (add_list_button);
            option_event.button_press_event.connect ( (event) => {
                add_list_signal ();
                return true;
            });

            update_list ();

            add (title_label);
            add (list_scrolled_window);
            add (alert);
            add (option_event);
        }

        private void create_list () {
            var all_list = new Gee.ArrayList<Interfaces.List?> ();
            all_list = db.get_all_lists (settings.get_int ("last-project-id"));

            if (all_list.size < 1) {
                list_scrolled_window.no_show_all = true;
                list_scrolled_window.visible = false;

                add_list_button.no_show_all = true;
                add_list_button.visible = false;

                alert.no_show_all = false;
                alert.visible = true;
            } else {
                list_scrolled_window.no_show_all = false;
                list_scrolled_window.visible = true;

                add_list_button.no_show_all = false;
                add_list_button.visible = true;

                alert.no_show_all = true;
                alert.visible = false;
            }

            foreach (var list in all_list) {
                var row = new ProgressRow (list);
                progress_litbox.add (row);
            }

            show_all ();
        }

        public void update_list () {
            foreach (Gtk.Widget element in progress_litbox.get_children ()) {
                progress_litbox.remove (element);
            }

            create_list ();
       }
    }

    public class ProgressRow : Gtk.Grid {
        private Gtk.Label title_label;
        private Gtk.LevelBar progressbar;

        private Interfaces.List lista_actual;

        public ProgressRow (Interfaces.List lista) {
            orientation = Gtk.Orientation.HORIZONTAL;
            height_request = 50;

            lista_actual = lista;
            tooltip_text = lista_actual.name;

            build_ui ();
        }

        private void build_ui () {
            title_label = new Gtk.Label ("<b>" + lista_actual.name + "</b>");
            title_label.vexpand = true;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            title_label.use_markup = true;
            title_label.margin_right = 12;
            title_label.ellipsize = Pango.EllipsizeMode.END;

            progressbar = new Gtk.LevelBar.for_interval (0, 1);
            progressbar.expand = true;
            progressbar.valign = Gtk.Align.CENTER;
            progressbar.margin_left = 12;
            progressbar.halign = Gtk.Align.END;
            progressbar.width_request = 200;

            double all =  lista_actual.task_all;
            double completed = lista_actual.tasks_completed;

            if (all == 0) {
                progressbar.value = 0;
            } else {
                progressbar.value = completed / all;
            }

            add (title_label);
            add (progressbar);
        }
    }
}
