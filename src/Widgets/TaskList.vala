namespace Planner {
    public class Widgets.TaskList : Gtk.Grid {
        private Gtk.Label title_label;
        private Gtk.Image icon_name;
        private Granite.Widgets.ModeButton mode_button;
        public TaskList () {
            orientation = Gtk.Orientation.VERTICAL;
            row_spacing = 12;
            margin_left = 12;
            margin_right = 12;

            build_ui ();
        }

        private void build_ui () {
            icon_name = new Gtk.Image.from_icon_name ("planner-star", Gtk.IconSize.DND);

            title_label = new Gtk.Label (_("<b>Today</b>"));
            title_label.use_markup = true;
            title_label.get_style_context ().add_class ("h2");

            mode_button = new Granite.Widgets.ModeButton ();
            mode_button.no_show_all = true;

            var open_toggle = new FormatButton ();
            open_toggle.icon = new ThemedIcon ("emblem-important-symbolic");
            open_toggle.text = _("Open");
            open_toggle.width_request = 100;

            var closed_toggle = new FormatButton ();
            closed_toggle.icon = new ThemedIcon ("emblem-ok-symbolic");
            closed_toggle.text = _("Closed");

            mode_button.append (open_toggle);
            mode_button.append (closed_toggle);

            mode_button.selected = 0;

            var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            main_box.hexpand = true;
            mode_button.valign = Gtk.Align.CENTER;
            main_box.pack_start (icon_name, false, false, 6);
            main_box.pack_start (title_label, false, false, 6);
            main_box.pack_end (mode_button, false, false, 0);

            var task_list_view = new Widgets.AllTaskList ();
            task_list_view.margin_top = 6;

            add (main_box);
            add (task_list_view);
        }

        public void set_index (int index) {
            if (index == 0) {
                icon_name.icon_name = "planner-star";
                title_label.label = _("<b>Today</b>");
                mode_button.visible = false;
            } else {
                icon_name.icon_name = "emblem-default";
                title_label.label = _("<b>Tasks</b>");
                mode_button.visible = true;
            }
        }
    }
}
