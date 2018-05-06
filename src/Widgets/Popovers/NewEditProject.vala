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
    public class Widgets.Popovers.NewEditProject : Gtk.Popover {
        private Gtk.Button next_button;
        private Gtk.Button previous_button;

        private Gtk.ToggleButton avatar_button;
        private Granite.Widgets.Avatar avatar;
        private Gdk.Pixbuf avatar_pixbuf;
        private Gtk.Image avatar_image;

        private Gtk.Label title_label;
        private Gtk.Entry name_entry;
        private Gtk.Label add_description_label;
        private Gtk.TextView description_textview;
        private Gtk.Switch duedate_switch;
        private Granite.Widgets.DatePicker duedate_datepicker;
        private Gtk.Revealer revealer_datepicker;

        private Gtk.Button add_button;
        private Gtk.Button remove_button;

        private Gee.ArrayList<string> project_types = Utils.project_types ();
        private int index = 0;
        private bool use_pixbuf = false;
        private bool update = false;
        private Objects.Project project_object;

        private Services.Database db;

        public signal void on_add_signal ();
        public signal void on_update_signal (Objects.Project project);
        public signal void on_remove_signal ();

        public NewEditProject (Gtk.Widget relative) {
            relative_to = relative;
            modal = true;
            position = Gtk.PositionType.TOP;

            project_object = new Objects.Project ();

            db = new Services.Database (true);

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.margin_top = 6;
            main_grid.margin_left = 12;
            main_grid.margin_right = 12;
            main_grid.margin_bottom = 12;
            main_grid.expand = true;
            main_grid.width_request = 250;

            title_label = new Gtk.Label (_("New Project"));
            title_label.use_markup = true;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            title_label.margin_right = 12;

            var info_image = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.MENU);
            info_image.tooltip_text = _("You can upload an Avatar from your computer \n" +
                                        "by clicking on the Avatar button.");
            info_image.has_tooltip = true;

            var top_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            top_box.halign = Gtk.Align.CENTER;

            top_box.pack_start (title_label, false, false, 0);
            top_box.pack_start (info_image, false, false, 0);

            avatar_image = new Gtk.Image.from_icon_name (project_types[index], Gtk.IconSize.DND);
            avatar_image.pixel_size = 64;

            avatar_button = new Gtk.ToggleButton ();
            avatar_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            avatar_button.image = avatar_image;

            next_button = new Gtk.Button.from_icon_name ("pan-end-symbolic", Gtk.IconSize.MENU);
            next_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            next_button.set_focus_on_click (false);
            next_button.clicked.connect ( () => {
                index = index + 1;

                if ( index >= project_types.size ) {
                    index = 0;
                }

                avatar_image.icon_name = project_types[index];
                avatar_button.image = avatar_image;
                use_pixbuf = false;

                if (update) {
                    add_button.sensitive = true;
                }
            });

            previous_button = new Gtk.Button.from_icon_name ("pan-start-symbolic", Gtk.IconSize.MENU);
            previous_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            previous_button.set_focus_on_click (false);
            previous_button.clicked.connect ( () => {
                index = index - 1;

                if (index <= -1) {
                    index = int.parse (project_types.size.to_string()) - 1;
                }

                avatar_image.icon_name = project_types[index];
                avatar_button.image = avatar_image;
                use_pixbuf = false;

                if (update) {
                    add_button.sensitive = true;
                }
            });

            var avatar_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            avatar_box.margin_top = 12;
            avatar_box.pack_start (previous_button, true, true, 0);
            avatar_box.pack_start (avatar_button, false, false, 0);
            avatar_box.pack_start (next_button, true, true, 0);

            name_entry = new Gtk.Entry ();
            name_entry.margin_bottom = 12;
            name_entry.hexpand = true;
            name_entry.max_length = 36;
            name_entry.placeholder_text = _("Name");
            name_entry.activate.connect (on_add_project);

            description_textview = new Gtk.TextView ();
            description_textview.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
            description_textview.expand = true;
            description_textview.margin_left = 1;

            add_description_label = new Gtk.Label ("Add Description");
            add_description_label.get_style_context ().add_class ("add_note");
            description_textview.add (add_description_label);

            var duedate_label = new Granite.HeaderLabel (_("Duedate"));

            duedate_switch = new Gtk.Switch ();
            duedate_switch.valign = Gtk.Align.CENTER;

            var duedate_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            duedate_box.margin_top = 12;
            duedate_box.pack_start (duedate_label, false, false, 0);
            duedate_box.pack_end (duedate_switch, false, false, 0);

            duedate_datepicker = new Granite.Widgets.DatePicker ();

            revealer_datepicker = new Gtk.Revealer ();
            revealer_datepicker.margin_top = 6;
            revealer_datepicker.reveal_child = false;
            revealer_datepicker.add (duedate_datepicker);

            add_button = new Gtk.Button.with_label (_("Create"));
            add_button.tooltip_text = _("Create a new project");
            add_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            add_button.sensitive = false;

            remove_button = new Gtk.Button.with_label (_("Delete"));
            remove_button.tooltip_text = _("Remove project");
            remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            remove_button.margin_right = 12;
            remove_button.sensitive = false;
            remove_button.no_show_all = true;

            var remove_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            remove_box.hexpand = true;
            remove_box.homogeneous = true;
            remove_box.no_show_all = true;

            var no_button = new Gtk.Button.with_label (_("No"));
            no_button.margin_right = 6;
            no_button.no_show_all = true;

            var yes_button = new Gtk.Button.with_label (_("Yes"));
            yes_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            yes_button.margin_right = 12;
            no_button.no_show_all = true;

            remove_box.pack_start (no_button, true, true, 0);
            remove_box.pack_start (yes_button, true, true, 0);


            var action_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            action_box.hexpand = true;
            action_box.homogeneous = true;
            action_box.margin_top = 12;

            action_box.pack_start (remove_box, true, true, 0);
            action_box.pack_start (remove_button, true, true, 0);
            action_box.pack_start (add_button, true, true, 0);

            // Signals
            name_entry.changed.connect ( () => {
                if (name_entry.text != "") {
                    add_button.sensitive = true;
                } else {
                    add_button.sensitive = false;
                }
            });

            duedate_switch.notify["active"].connect( () => {
                if (duedate_switch.active) {
                    revealer_datepicker.reveal_child = true;
                } else {
                    revealer_datepicker.reveal_child = false;
                    project_object.final_date = "";
                }

                if (update) {
                    add_button.sensitive = true;
                }
            });

            description_textview.focus_in_event.connect ( () => {
                add_description_label.visible = false;
                return false;
            });

            description_textview.focus_out_event.connect ( () => {
                if (description_textview.buffer.text == "") {
                    add_description_label.visible = true;
                }
                return false;
            });

            description_textview.buffer.changed.connect ( () => {
                if (update) {
                    add_button.sensitive = true;
                }
            });

            description_textview.key_press_event.connect ( (key) => {
                if (key.keyval == Gdk.Key.Return) {
                    on_add_project ();
                }

                return false;
            });

            duedate_datepicker.date_changed.connect ( () => {
                if (update) {
                    add_button.sensitive = true;
                }
            });

            remove_button.clicked.connect ( () => {
                remove_button.visible = false;

                remove_box.visible = true;
                yes_button.visible = true;
                no_button.visible = true;
            });

            yes_button.clicked.connect ( () => {
                db.remove_project (project_object);
                on_remove_signal ();
                hide ();
            });

            no_button.clicked.connect ( () => {
                remove_button.visible = true;

                remove_box.visible = false;
                yes_button.visible = false;
                no_button.visible = false;
            });

            avatar_button.toggled.connect (() => {
                if (avatar_button.active) {
                    var file_dialog = new Gtk.FileChooserDialog (_("Select an image"),
                    get_parent_window () as Gtk.Window?, Gtk.FileChooserAction.OPEN, _("Cancel"),
                    Gtk.ResponseType.CANCEL, _("Open"), Gtk.ResponseType.ACCEPT);

                    Gtk.FileFilter filter = new Gtk.FileFilter ();
                    filter.set_filter_name (_("Images"));
                    file_dialog.set_filter (filter);
                    filter.add_mime_type ("image/jpeg");
                    filter.add_mime_type ("image/jpg");
                    filter.add_mime_type ("image/png");
                    filter.add_mime_type ("image/svg");
                    filter.add_pattern ("*.svg");

                    Gtk.Image preview_area = new Gtk.Image ();
                    file_dialog.set_preview_widget (preview_area);
                    file_dialog.update_preview.connect (() => {
                        string uri = file_dialog.get_preview_uri ();
                        // We only display local files:
                        if (uri != null && uri.has_prefix ("file://") == true) {
                            try {
                                Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (uri.substring (7), 150, 150, true);
                                preview_area.set_from_pixbuf (pixbuf);
                                preview_area.show ();
                                file_dialog.set_preview_widget_active (true);
                            } catch (Error e) {
                                preview_area.hide ();
                                file_dialog.set_preview_widget_active (false);
                            }
                        } else {
                            preview_area.hide ();
                            file_dialog.set_preview_widget_active (false);
                        }
                    });
                    if (file_dialog.run () == Gtk.ResponseType.ACCEPT) {
                    var path = file_dialog.get_file ().get_path ();
                        file_dialog.hide ();
                        file_dialog.destroy ();

                        var avatar_dialog = new Dialogs.AvatarDialog (path);
                        avatar_dialog.request_avatar_change.connect ( (pixbuf) => {
                            if (avatar == null) {
                                avatar = new Granite.Widgets.Avatar.from_pixbuf (pixbuf);
                            } else {
                                avatar.pixbuf = pixbuf;
                            }
                            avatar_button.image = avatar;
                            avatar_button.active = false;

                            avatar_pixbuf = pixbuf;
                            use_pixbuf = true;

                            if (update) {
                                add_button.sensitive = true;
                            }
                        });
                    } else {
                        file_dialog.close ();
                        avatar_button.active = false;
                    }
                }
                name_entry.grab_focus ();
            });

            this.closed.connect ( () => {
                if (update) {
                    remove_button.visible = true;
                } else {
                    remove_button.visible = false;
                }

                remove_box.visible = false;
                yes_button.visible = false;
                no_button.visible = false;
            });

            this.show.connect ( () => {
                if (description_textview.buffer.text == "") {
                    add_description_label.visible = true;
                } else {
                    add_description_label.visible = false;
                }

                name_entry.grab_focus ();
            });


            add_button.clicked.connect (on_add_project);

            main_grid.add (top_box);
            main_grid.add (avatar_box);
            main_grid.add (new Granite.HeaderLabel (_("Project Name")));
            main_grid.add (name_entry);
            main_grid.add (new Granite.HeaderLabel (_("Description")));
            main_grid.add (description_textview);
            main_grid.add (duedate_box);
            main_grid.add (revealer_datepicker);
            main_grid.add (action_box);

            add (main_grid);
            name_entry.grab_focus ();
        }

        private void on_add_project () {
            if (name_entry.text != "") {
                var datetime = new GLib.DateTime.now_local ();
                string start_date = datetime.format ("%F");
                string final_date = "";

                if (duedate_switch.active) {
                    final_date = duedate_datepicker.date.format ("%F");
                }

                project_object.name = name_entry.text;
                project_object.description = description_textview.buffer.text;
                project_object.start_date = start_date;
                project_object.final_date = final_date;
                project_object.last_update = datetime.format ("%F");

                if (update) { // Update Project
                    if (use_pixbuf) {
                        string name_avatar = "avatar-" + project_object.id.to_string () + ".png";
                        string path = Environment.get_home_dir () + "/.local/share/com.github.alainm23.planner/project-avatar/" + name_avatar;
                        avatar_pixbuf.savev (path, "png", {}, {});
                        project_object.avatar = name_avatar;
                    } else {
                        project_object.avatar = avatar_image.icon_name;
                    }
                } else { // New Project
                    if (use_pixbuf) {
                        int random = Random.int_range (1, 99999999);
                        string name_avatar = "avatar-" + random.to_string () + ".png";
                        string path = Environment.get_home_dir () + "/.local/share/com.github.alainm23.planner/project-avatar/" + name_avatar;

                        avatar_pixbuf.savev (path, "png", {}, {});
                        project_object.avatar = name_avatar;
                    } else {
                        project_object.avatar = avatar_image.icon_name;
                    }
                }

                if (update) {
                    db.update_project (project_object);
                    on_update_signal (project_object);
                } else {
                    db.add_project (project_object);
                    on_add_signal ();
                }

                hide ();
                clear_all ();
                update = false;
            }
        }

        private void clear_all () {
            name_entry.text = "";
            description_textview.buffer.text = "";

            index = 0;
            avatar_image.icon_name = project_types[0];
            avatar_button.image = avatar_image;
            use_pixbuf = false;

            duedate_switch.active = false;
            revealer_datepicker.reveal_child = false;

            project_object = new Objects.Project ();
        }

        public void set_project_edit (Objects.Project project) {
            project_object = db.get_project (project.id);

            title_label.label = _("Edit Project");
            name_entry.text = project_object.name;

            if (Utils.is_avatar_icon (project_object.avatar)) {
                avatar_image.icon_name = project_object.avatar;
                use_pixbuf = false;
            } else {
                string path = Environment.get_home_dir () +
                    "/.local/share/com.github.alainm23.planner/project-avatar/" +
                    project_object.avatar;

                avatar = new Granite.Widgets.Avatar.from_file (path, 64);
                avatar_button.image = avatar;
                avatar_pixbuf = avatar.pixbuf;
                use_pixbuf = true;
            }

            if (project_object.description != "") {
                description_textview.buffer.text = project.description;
                add_description_label.no_show_all = true;
            }

            if (project_object.final_date != "") {
                duedate_switch.active = true;
                duedate_datepicker.date = from_iso8601 (project_object.final_date + "T09:14:46+00:00");
            }

            remove_button.visible = true;
            remove_button.sensitive = true;
            add_button.sensitive = false;
            add_button.label = _("Update");
            update = true;
        }

        private DateTime from_iso8601 (string iso_date) {
            TimeVal tv = TimeVal ();
            if (tv.from_iso8601 (iso_date))
                return new DateTime.from_timeval_local (tv);
            return new DateTime.now_local ();
        }
    }
}
