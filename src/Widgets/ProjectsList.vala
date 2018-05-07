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
    public class Widgets.ProjectsList : Gtk.Grid {
        private Gtk.Label title_label;
        private Gtk.ListBox projects_listbox;
        private Widgets.ModelButton add_button;
        private Gtk.ToggleButton options_button;

        private Widgets.Popovers.NewEditProject add_popover;

        private Services.Database db;
        private Services.Settings settings;

        public signal void on_selected_project (Objects.Project project);

        public ProjectsList () {
            db = new Services.Database (true);
            settings = new Services.Settings ();

            expand = true;
            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.row_spacing = 12;

            title_label = new Gtk.Label ("<b>%s</b>".printf (_("Projects")));
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.halign = Gtk.Align.START;
            title_label.use_markup = true;

            var info_image = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.MENU);
            info_image.tooltip_text = _("- Select a project to start working.\n" +
                                        "- Remember that you can also edit and delete a project.");

            var top_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            top_box.margin_left = 12;
            top_box.margin_right = 12;
            top_box.pack_start (title_label, false, false, 0);
            top_box.pack_end (info_image, false, false, 0);

            projects_listbox = new Gtk.ListBox  ();
            projects_listbox.activate_on_single_click = true;
            projects_listbox.selection_mode = Gtk.SelectionMode.SINGLE;
            projects_listbox.vexpand = true;
            projects_listbox.get_style_context ().add_class (Gtk.STYLE_CLASS_POPOVER);
            projects_listbox.row_activated.connect (on_project_selected);

            var list_scrolled_window = new Gtk.ScrolledWindow (null, null);
            list_scrolled_window.expand = true;
            list_scrolled_window.add (projects_listbox);

            add_button = new Widgets.ModelButton (_("New Project"), _("Create a new project"), "list-add-symbolic");

            options_button = new Gtk.ToggleButton ();
            options_button.image = new Gtk.Image.from_icon_name ("view-more-symbolic", Gtk.IconSize.MENU);
            options_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            var actionbar_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            actionbar_box.margin_right = 6;
            actionbar_box.margin_left = 6;

            actionbar_box.pack_start (add_button, false, false, 0);
            actionbar_box.pack_end (options_button, false, false, 0);

            add_popover = new Widgets.Popovers.NewEditProject (add_button);
            add_button.toggled.connect ( () => {
                if (add_button.active) {
                    add_popover.show_all ();
                }
            });

            add_popover.closed.connect ( () => {
                add_button.active = false;
            });

            add_popover.on_add_signal.connect (update_list);

            main_grid.add (top_box);
            main_grid.add (list_scrolled_window);
            main_grid.add (actionbar_box);

            add (main_grid);

            create_list ();
        }

        private void create_list () {
            // get all projects
            var all_projects = new Gee.ArrayList<Objects.Project?> ();
            all_projects = db.get_all_projects ();

            foreach (var project in all_projects) {
                var row = new Widgets.ProjectRow (project);
                projects_listbox.add (row);
            }

            options_button.grab_focus ();
            show_all ();
        }

        public void update_list () {
            foreach (Gtk.Widget element in projects_listbox.get_children ()) {
                projects_listbox.remove (element);
            }

            create_list ();
        }

        private void on_project_selected (Gtk.ListBoxRow list_box_row) {
            var project_row = list_box_row.get_child () as ProjectRow;
            on_selected_project (project_row.project_object);

            update_list ();
        }
    }
}
