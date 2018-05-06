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
    public class Dialogs.AvatarDialog : Gtk.Dialog {
        private string              pixbuf_path;

        private Gtk.Grid            main_grid;
        private Gtk.Widget          button_change;
        private Gtk.Widget          button_cancel;
        private Widgets.CropView    cropview;

        public signal void request_avatar_change (Gdk.Pixbuf pixbuf);

        public AvatarDialog (string pixbuf_path) {
            this.pixbuf_path = pixbuf_path;

            set_size_request (400, 0);
            set_resizable (false);
            set_deletable (false);
            set_modal (true);

            build_ui ();
            build_buttons ();
            show_all ();
        }

        private void build_ui () {
            var content = get_content_area () as Gtk.Box;
            get_action_area ().margin = 6;
            main_grid = new Gtk.Grid ();
            main_grid.expand = true;
            main_grid.margin = 12;
            main_grid.row_spacing = 10;
            main_grid.column_spacing = 20;
            main_grid.halign = Gtk.Align.CENTER;
            content.add (main_grid);

            try {
                cropview = new Widgets.CropView.from_pixbuf_with_size (new Gdk.Pixbuf.from_file (pixbuf_path), 400, 300);
                cropview.quadratic_selection = true;
                cropview.handles_visible = false;

                Gtk.Frame frame = new Gtk.Frame (null);
                frame.add (cropview);

                main_grid.attach (frame, 0, 0, 1, 1);
            } catch (Error e) {
                critical (e.message);
                button_change.set_sensitive (false);
            }
        }

        private void build_buttons () {
            button_cancel = add_button (_("Cancel"), Gtk.ResponseType.CLOSE);
            button_change = add_button (_("Select Avatar"), Gtk.ResponseType.OK);
            button_change.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            this.response.connect (on_response);
        }

        private void on_response (Gtk.Dialog source, int response_id) {
            if (response_id == Gtk.ResponseType.OK) {
                var pixbuf = cropview.get_selection ();
                request_avatar_change (pixbuf.scale_simple (64, 64, Gdk.InterpType.BILINEAR));
            }

            hide ();
            destroy ();
        }
    }
}
