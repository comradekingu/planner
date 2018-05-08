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
    public class Widgets.ProjectRow : Gtk.EventBox {
        private Gtk.Image avatar_image;
        private Granite.Widgets.Avatar avatar;
        private Gtk.Label name_label;
        private Gtk.Label last_update_label;
        private Gtk.ToggleButton preferences_button;
        private Gtk.Revealer preferences_revealer;

        private bool edit = false;
        public Objects.Project project_object;

        public ProjectRow (Objects.Project _object) {
            project_object = _object;
            tooltip_text = project_object.description;

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.column_spacing = 12;
            main_grid.margin = 6;

            avatar_image = new Gtk.Image ();
            avatar_image.pixel_size = 56;

            avatar = new Granite.Widgets.Avatar ();

            if (Utils.is_avatar_icon (project_object.avatar)) {
                avatar_image.icon_name = project_object.avatar;
            } else {
                string path = Environment.get_home_dir () +
                    "/.local/share/com.github.alainm23.planner/project-avatar/" +
                    project_object.avatar;
                var avatar_pixbuf = new Gdk.Pixbuf.from_file_at_scale (path, 48, 48, true);
                avatar.pixbuf = avatar_pixbuf;
            }

            name_label = new Gtk.Label ("<b>%s</b>".printf (project_object.name));
            name_label.ellipsize = Pango.EllipsizeMode.END;
            name_label.xalign = 0;
            name_label.valign = Gtk.Align.END;
            name_label.use_markup = true;

            var img = new Gtk.Image ();
            img.icon_name = "appointment-symbolic";
            img.pixel_size = 12;
            img.margin_right = 3;

            last_update_label = new Gtk.Label ("");
            last_update_label.label = "<small>%s</small>".printf (date_differences (project_object.last_update));
            last_update_label.use_markup = true;
            last_update_label.ellipsize = Pango.EllipsizeMode.END;
            last_update_label.xalign = 0;

            var last_update_box = new Gtk.Grid ();
            last_update_box.valign = Gtk.Align.START;

            last_update_box.add (img);
            last_update_box.add (last_update_label);

            preferences_button = new Gtk.ToggleButton ();
            preferences_button.image = new Gtk.Image.from_icon_name ("application-menu-symbolic", Gtk.IconSize.MENU);
            preferences_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            preferences_button.halign = Gtk.Align.CENTER;
            preferences_button.valign = Gtk.Align.CENTER;

            preferences_revealer = new Gtk.Revealer ();
            preferences_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            preferences_revealer.add (preferences_button);
            preferences_revealer.reveal_child = false;
            preferences_revealer.hexpand = true;
            preferences_revealer.halign = Gtk.Align.END;

            var edit_popover = new Widgets.Popovers.NewEditProject (preferences_button);
            edit_popover.position = Gtk.PositionType.RIGHT;

            preferences_button.toggled.connect ( () => {
                if (preferences_button.active) {
                    edit = true;
                    edit_popover.set_project_edit (project_object);
                    edit_popover.show_all ();
                }
            });

            edit_popover.closed.connect ( () => {
                preferences_revealer.reveal_child = false;
                preferences_button.active = false;
                edit = false;
            });

            edit_popover.on_remove_signal.connect ( () => {
                Timeout.add (20, () => {
                    this.opacity = this.opacity - 0.1;

                    if (this.opacity == 0) {
                        destroy ();
                        return false;
                    }
                    return true;
                });
            });

            edit_popover.on_update_signal.connect ( (project) => {
                project_object = project;
                name_label.label = "<b>%s</b>".printf (project_object.name);
                last_update_label.label = "<small>%s</small>".printf (date_differences (project.last_update));
                tooltip_text = project.description;

                if (Utils.is_avatar_icon (project_object.avatar)) {
                    avatar_image.icon_name = project_object.avatar;

                    avatar_image.visible = true;
                    avatar.visible = false;
                } else {
                    string path = Environment.get_home_dir () +
                        "/.local/share/com.github.alainm23.planner/project-avatar/" +
                        project_object.avatar;
                    var avatar_pixbuf = new Gdk.Pixbuf.from_file_at_scale (path, 48, 48, true);
                    avatar.pixbuf = avatar_pixbuf;

                    avatar_image.visible = false;
                    avatar.visible = true;
                }
            });

            this.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
            this.enter_notify_event.connect ( (event) => {
                if (edit != true) {
                    preferences_revealer.reveal_child = true;
                }
                return false;
            });

            this.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }

                if (edit != true) {
                    preferences_revealer.reveal_child = false;
                }
                return false;
            });

            main_grid.attach (avatar_image, 0, 0, 1, 2);
            main_grid.attach (avatar, 0, 0, 1, 2);
            main_grid.attach (name_label, 1, 0, 1, 1);
            main_grid.attach (last_update_box, 1, 1, 1, 1);
            main_grid.attach (preferences_revealer, 2, 0, 2, 2);

            add (main_grid);

            show_all ();
        }

        private string date_differences (string d) {
            var date_now = new GLib.DateTime.now_local ();
            var date = from_iso8601 (d + "T09:14:46+00:00");

            int days_1 = get_days (date_now);
            int days_2 = get_days (date);

            int days_total = days_1 - days_2;

            string days = "";

            if (days_total == 0) {
                days = _("Updated today");
            } else if (days_total == 1) {
                days = _("Updated yesterday");
            } else {
                days = _("Updated 26 %s days ago").printf(days_total.to_string ());
            }

            return days;
        }

        private DateTime from_iso8601 (string iso_date) {
            TimeVal tv = TimeVal ();
            if (tv.from_iso8601 (iso_date))
                return new DateTime.from_timeval_local (tv);
            return new DateTime.now_local ();
        }

        private int get_days (DateTime date) {
            var _date = date;

            int y = _date.get_year ();
            int m = _date.get_month ();
            int d = _date.get_day_of_month ();

            int days = y * 365 + m * 12 + d;

            return days;
        }
    }
}
