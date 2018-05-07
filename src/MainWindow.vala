/*
* Copyright (c) 2018 Alain M. (https://github.com/alainm23/planner)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alain M. <alain23@protonmail.com>
*/

namespace Planner {
    public class MainWindow : Gtk.Window {
        private Gtk.Stack main_stack;

        private Widgets.Headerbar headerbar;
        private Views.TodayView today_view;
        private Views.OverviewView overview_view;
        private Views.IssuesView issues_view;
        private Views.TasksView tasks_view;

        private Services.Database db;
        private Services.Settings settings;

        private int index;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                icon_name: "com.github.alainm23.planner",
                title: _("Planner")
            );


            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/alainm23/planner");

            // Dir to Database
            Utils.create_dir_with_parents ("/.local/share/com.github.alainm23.planner");

            // Dir to Projects avatar
            Utils.create_dir_with_parents ("/.local/share/com.github.alainm23.planner/project-avatar");

            db = new Services.Database ();
            settings = new Services.Settings ();

            var window_x = settings.window_x;
            var window_y = settings.window_y;
            move (window_x, window_y);

            var window_width = settings.window_width;
            var window_height = settings.window_height;
            set_default_size (window_width, window_height);

            this.delete_event.connect ( () => {
                int current_x, current_y, width, height;
                get_position (out current_x, out current_y);
                get_size (out width, out height);

                settings.window_x = current_x;
                settings.window_y = current_y ;
                settings.window_width = width;
                settings.window_height = height;

                settings.project_sidebar_width = today_view.position;

                return false;
            });

            build_ui ();
        }

        private void build_ui () {
            main_stack = new Gtk.Stack ();
            main_stack.transition_duration = 400;
            main_stack.expand = true;
            main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;

            headerbar = new Widgets.Headerbar ();
            set_titlebar (headerbar);

            today_view = new Views.TodayView ();
            overview_view = new Views.OverviewView ();
            tasks_view = new Views.TasksView ();
            issues_view = new Views.IssuesView ();

            main_stack.add_named (today_view, "today_view");
            main_stack.add_named (overview_view, "overview_view");
            main_stack.add_named (tasks_view, "tasks_view");
            main_stack.add_named (issues_view, "issues_view");
            main_stack.visible_child_name = "today_view";

            today_view.selected_project.connect ( (project) => {
                main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                main_stack.visible_child_name = "overview_view";

                headerbar.update_project (project);
                headerbar.enable_all ();
            });

            headerbar.on_back_button.connect ( () => {
                main_stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                main_stack.visible_child_name = "today_view";

                headerbar.disable_all ();
            });

            headerbar.on_selected_view.connect ( (index_bar) => {
                if (index > index_bar) {
                    main_stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                } else {
                    main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                }

                if (index_bar == 0) {
                    main_stack.visible_child_name = "overview_view";
                } else if (index_bar == 1) {
                    main_stack.visible_child_name = "tasks_view";
                } else if (index_bar == 2) {
                    main_stack.visible_child_name = "issues_view";
                }

                index = index_bar;
            });

            add (main_stack);
            show_all ();
        }
    }
}
