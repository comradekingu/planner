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
    public class Views.TodayView : Gtk.Paned {
        public Widgets.ProjectsList project_list_widget;
        private Widgets.TodayNotification today_totification;

        private Services.Settings settings;

        public signal void selected_project (Objects.Project project);

        public TodayView () {
            get_style_context ().add_class ("welcome");
            margin_top = 24;
            margin_bottom = 12;
            margin_left = 24;
            orientation = Gtk.Orientation.HORIZONTAL;

            settings = new Services.Settings ();
            position = settings.project_sidebar_width;

            build_ui ();
        }

        private void build_ui () {

            project_list_widget = new Widgets.ProjectsList ();
            today_totification = new Widgets.TodayNotification ();

            project_list_widget.on_selected_project.connect ( (project) => {
                selected_project (project);
            });

            pack1 (project_list_widget, false, false);
            pack2 (today_totification, true, true);
        }
    }
}
