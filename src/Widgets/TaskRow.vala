namespace Planner {
    public class Widgets.TaskRow : Gtk.EventBox {
        private Gtk.Label name_label;
        private Gtk.Button fullscreen_button;
        private Gtk.Revealer fullscreen_revealer;
        private Gtk.Revealer main_revealer;
        private Gtk.TextView note_textview;
        private Gtk.Button completed_button;
        private Gtk.Button milestone_button;
        private Gtk.Button checklist_button;
        private Gtk.Button deadline_button;
        private Gtk.Button tag_button;
        private Gtk.Button remove_button;

        public Objects.Task task_object;

        private bool show_all = false;

        public TaskRow (Objects.Task task) {
            get_style_context ().add_class ("task_hover");
            add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
            margin_left = 6;
            margin_right = 12;
            valign = Gtk.Align.CENTER;

            task_object = task;
            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.expand = true;
            main_grid.orientation = Gtk.Orientation.VERTICAL;

            name_label = new Gtk.Label ("<b>%s</b>".printf(task_object.name));
            name_label.get_style_context ().add_class ("h3");
            name_label.set_ellipsize (Pango.EllipsizeMode.END);
            name_label.use_markup = true;
            name_label.tooltip_text = task_object.name;

            fullscreen_button = new Gtk.Button.from_icon_name ("view-fullscreen-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            fullscreen_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            completed_button = new Gtk.Button.with_label (_("Complete"));
            completed_button.no_show_all = true;
            completed_button.valign = Gtk.Align.CENTER;
            completed_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            completed_button.margin_right = 6;

            fullscreen_revealer = new Gtk.Revealer ();
            fullscreen_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            fullscreen_revealer.add (fullscreen_button);
            fullscreen_revealer.reveal_child = false;

            var top_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            top_box.hexpand = true;
            top_box.margin = 6;
            top_box.margin_left = 12;


            top_box.pack_start (name_label, false, false, 0);
            top_box.pack_end (fullscreen_revealer, false, false, 0);
            top_box.pack_end (completed_button, false, false, 0);

            var horizontal_grid = new Gtk.Grid ();
            horizontal_grid.orientation = Gtk.Orientation.HORIZONTAL;

            var left_grid = new Gtk.Grid ();
            left_grid.margin_left = 12;
            left_grid.margin_top = 6;
            left_grid.orientation = Gtk.Orientation.VERTICAL;

            var right_grid = new Gtk.Grid ();
            right_grid.orientation = Gtk.Orientation.VERTICAL;
            right_grid.valign = Gtk.Align.END;

            horizontal_grid.add (left_grid);
            horizontal_grid.add (right_grid);

            main_revealer = new Gtk.Revealer ();
            main_revealer.add (horizontal_grid);
            main_revealer.reveal_child = false;

            note_textview = new Gtk.TextView ();
            note_textview.expand = true;
            note_textview.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
            note_textview.height_request = 100;
            left_grid.add (note_textview);

            var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
            separator.no_show_all = true;

            remove_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            milestone_button = new Gtk.Button.from_icon_name ("edit-flag-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            milestone_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            tag_button = new Gtk.Button.from_icon_name ("tag-new-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            tag_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            deadline_button = new Gtk.Button.from_icon_name ("office-calendar-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            deadline_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            checklist_button = new Gtk.Button.from_icon_name ("view-list-compact-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            checklist_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            var action_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            action_box.margin_right = 6;
            action_box.margin_bottom = 6;
            action_box.pack_start (checklist_button, false, false, 0);
            action_box.pack_start (deadline_button, false, false, 0);
            action_box.pack_start (tag_button, false, false, 0);
            action_box.pack_start (milestone_button, false, false, 0);
            action_box.pack_start (remove_button, false, false, 0);

            right_grid.add (action_box);

            this.enter_notify_event.connect ( (event) => {
                if (main_revealer.reveal_child != true) {
                    fullscreen_revealer.reveal_child = true;
                }
                return false;
            });

            this.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }

                if (main_revealer.reveal_child != true) {
                    fullscreen_revealer.reveal_child = false;
                }

                return false;
            });

            fullscreen_button.clicked.connect ( () => {
                if (main_revealer.reveal_child) {
                    main_revealer.reveal_child = false;
                    get_style_context ().add_class ("task_hover");
                    get_style_context ().remove_class ("task_selected");
                    get_style_context ().remove_class (Gtk.STYLE_CLASS_POPOVER);

                    completed_button.visible = false;
                    separator.visible = false;

                    fullscreen_button.image = new Gtk.Image.from_icon_name ("view-fullscreen-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
                } else {
                    main_revealer.reveal_child = true;

                    get_style_context ().remove_class ("task_hover");
                    get_style_context ().add_class ("task_selected");
                    get_style_context ().add_class (Gtk.STYLE_CLASS_POPOVER);

                    completed_button.visible = true;
                    separator.visible = true;

                    fullscreen_button.image = new Gtk.Image.from_icon_name ("close-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

                    note_textview.grab_focus ();
                }
            });

            main_grid.add (top_box);
            main_grid.add (separator);
            main_grid.add (main_revealer);

            add (main_grid);
        }
    }
}
