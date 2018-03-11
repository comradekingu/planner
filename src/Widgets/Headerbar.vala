namespace Planner {
    public class Headerbar : Gtk.HeaderBar {

        private FormatBar format_bar;
        private ProjectButton project_button;

        private Gtk.MenuButton team_button;
        private Gtk.MenuButton app_menu;

        private ProjectPopover project_popover;

        public signal void update_project (Project project);
        public signal void on_headerbar_change (string name_bar);

        public Headerbar () {

            set_show_close_button (true);
            get_style_context ().add_class ("compact");
            set_title ("Planner");

            build_ui ();
        }

        private void build_ui () {

            project_button = new ProjectButton ();

            project_popover = new ProjectPopover (project_button);
            project_button.clicked.connect ( () => {

                project_popover.show_all ();

            });
            project_popover.selected_project.connect (set_actual_project);

            format_bar = new FormatBar ();
            set_custom_title (format_bar);
            format_bar.on_formarbar_select.connect ( (name_bar) => {
                on_headerbar_change (name_bar);
            });
        

            // ------- Team Button -------------------------------------

            team_button = new Gtk.MenuButton ();
            team_button.image = new Gtk.Image.from_icon_name ("system-users", Gtk.IconSize.LARGE_TOOLBAR);
            team_button.set_border_width (4);

            // ------- App Menu ---------------------------------
            var menu_grid = new Gtk.Grid ();
            menu_grid.margin_bottom = 3;
            menu_grid.orientation = Gtk.Orientation.VERTICAL;
            menu_grid.width_request = 200;
            menu_grid.show_all ();

            var menu = new Gtk.Popover (null);
            menu.add (menu_grid);

            app_menu = new Gtk.MenuButton ();
            app_menu.image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
            app_menu.tooltip_text = _("Menu");
            app_menu.set_border_width (4);
            app_menu.popover = menu;

            pack_start (project_button);
            pack_end (app_menu);
            pack_end (team_button);
        }

        public void disable_all () {

            project_button.set_sensitive (false);
            project_button.set_opacity (0);

            format_bar.set_sensitive (false);
            format_bar.set_opacity (0);

            team_button.set_sensitive (false);
            team_button.set_opacity (0);

            app_menu.set_sensitive (false);
            app_menu.set_opacity (0);

        }

        public void enable_all () {

            project_button.set_sensitive (true);
            project_button.set_opacity (1);

            format_bar.set_sensitive (true);
            format_bar.set_opacity (1);

            team_button.set_sensitive (true);
            team_button.set_opacity (1);

            app_menu.set_sensitive (true);
            app_menu.set_opacity (1);

            update_widget ();

        }

        private void set_actual_project (Project project) {

            project_button.set_project (project);

            update_project (project);

        }

        private void update_widget () {

            project_popover.update_widget ();

        }

        public void set_project (Project project) {

            project_button.set_project (project);

            update_widget ();
        }
    }
}
