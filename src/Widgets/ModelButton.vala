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
    public class Widgets.ModelButton : Gtk.ToggleButton {
        private Gtk.Image icon;
        private Gtk.Label text_label;

        public ModelButton (string text = "", string tooltip = "", string icon_name = "") {
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            tooltip_text = tooltip;

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.HORIZONTAL;

            icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.SMALL_TOOLBAR);

            text_label = new Gtk.Label ("<b>%s</b>".printf(text));
            text_label.use_markup = true;

            main_grid.add (icon);
            main_grid.add (text_label);

            add (main_grid);
        }
    }
}
