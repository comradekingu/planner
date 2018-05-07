namespace Planner {
    public class Widgets.Headerbar : Gtk.HeaderBar {
        private Gtk.Button back_button;
        private Widgets.ProjectButton project_button;
        private Widgets.FormatBar format_bar;
        private Gtk.MenuButton app_menu;

        public signal void on_back_button ();
        public signal void on_selected_view (int index);

        public Headerbar () {
            set_show_close_button (true);
            get_style_context ().add_class ("compact");
            set_title (_("Planner"));

            build_ui ();
        }

        private void build_ui () {
            back_button = new Gtk.Button.with_label (_("Today"));
            back_button.get_style_context ().add_class (Granite.STYLE_CLASS_BACK_BUTTON);
            back_button.valign = Gtk.Align.CENTER;
            back_button.margin_top = 2;
            back_button.no_show_all = true;

            project_button = new Widgets.ProjectButton ();
            project_button.margin_left = 6;
            project_button.no_show_all = true;

            format_bar = new Widgets.FormatBar ();

            var menu = new Gtk.Popover (null);

            app_menu = new Gtk.MenuButton ();
            //app_menu.border_width = 4;
            app_menu.image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
            app_menu.tooltip_text = _("Preferences");
            app_menu.popover = menu;

            back_button.clicked.connect ( () => {
                back_button.visible = false;
                on_back_button ();
            });

            format_bar.on_formarbar_select.connect ( (index) => {
                on_selected_view (index);
            });

            pack_start (back_button);
            pack_start (project_button);
            pack_end (app_menu);

            disable_all ();
        }

        public void disable_all () {
            back_button.visible = false;
            project_button.visible = false;
            set_custom_title (null);
        }

        public void enable_all () {
            back_button.visible = true;
            project_button.no_show_all = false;
            set_custom_title (format_bar);

            show_all ();
        }

        public void update_project (Objects.Project project) {

        }
    }
}
