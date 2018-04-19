namespace Planner {

	public class NewEditListPopover : Gtk.Popover {

		private Gtk.Label title_label;
		private Gtk.Entry name_entry;
        private Gtk.FlowBox flow_box;
        private Gtk.Button add_button;
		private Gtk.Button remove_button;
        private Gtk.SpinButton spin_button;
        private string icon_image;

        private Services.Database db;
        private GLib.Settings settings;

		private Interfaces.List list_actual;

		private bool edit_bool = false;

        public signal void created_list ();
		public signal void update_list (Interfaces.List list);
		public signal void remove_list ();

		public NewEditListPopover (Gtk.Widget relative) {

			relative_to = relative;
            modal = true;
            position = Gtk.PositionType.BOTTOM;

			list_actual = new Interfaces.List ();
			db = new Services.Database (true);
            settings = new GLib.Settings ("com.github.alainm23.planner");
			icon_image = Utils.name_icon_list()[6];

			build_ui ();
		}

		private void build_ui () {

			var main_grid = new Gtk.Grid ();
        	main_grid.orientation = Gtk.Orientation.VERTICAL;
        	main_grid.row_spacing = 12;
        	main_grid.margin = 12;
        	main_grid.expand = true;
        	main_grid.width_request = 250;

            title_label = new Gtk.Label (_("<b>New List</b>"));
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
        	title_label.use_markup = true;

			remove_button = new Gtk.Button.with_label (_("Remove"));
			remove_button.tooltip_text = _("Create a new List");
			remove_button.valign = Gtk.Align.CENTER;
			remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
			remove_button.no_show_all = true;
			remove_button.clicked.connect ( () => {
				db.remove_list (list_actual);
				remove_list ();
				hide ();
			});

        	add_button = new Gtk.Button.with_label (_("Save"));
            add_button.tooltip_text = _("Create a new List");
            add_button.halign = Gtk.Align.END;
            add_button.valign = Gtk.Align.CENTER;
            add_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            add_button.sensitive = false;
            add_button.clicked.connect ( () => {
                // Create_list to db
                create_list ();
                // hide popover
                hide ();
            });

            name_entry = new Gtk.Entry ();
            name_entry.max_length = 36;
            name_entry.placeholder_text = _("Title List");
            name_entry.changed.connect ( () => {

                if (name_entry.text == "") {

                    add_button.sensitive = false;

                } else {

                    add_button.sensitive = true;

                }

            });

            var title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            title_box.hexpand = true;

            title_box.pack_start (title_label, false, true, 0);
            title_box.pack_end (add_button, false, true, 6);
			title_box.pack_end (remove_button, false, false, 0);


            flow_box = new Gtk.FlowBox ();
            flow_box.homogeneous = true;
            flow_box.column_spacing = 6;
            flow_box.row_spacing = 6;


            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.expand = true;
            scrolled.height_request = 136;
            scrolled.add (flow_box);

            flow_box.get_children ().@foreach ((child) => {

                child.destroy ();

            });

            foreach (string name in Utils.name_icon_list ()) {

                var icon_image = new Granite.AsyncImage.from_icon_name_async (name, Gtk.IconSize.LARGE_TOOLBAR);

                flow_box.add (icon_image);
                flow_box.show_all ();

            }

            flow_box.child_activated.connect ( (child) => {

                flow_box.select_child (child);
				add_button.sensitive = true;

                icon_image = Utils.name_icon_list()[child.get_index ()];

            });

            var assigned_lavel = new Granite.HeaderLabel (_("Assigned Days"));
            spin_button = new Gtk.SpinButton.with_range (0, 100, 1);

            var spin_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            spin_box.hexpand = true;

            spin_box.pack_start (assigned_lavel, false, true, 0);
            spin_box.pack_end (spin_button, false, true, 0);


            main_grid.add (title_box);
            main_grid.add (name_entry);
            main_grid.add (scrolled);
            //main_grid.add (spin_box);
            add (main_grid);
            name_entry.grab_focus ();

		}

        private void create_list () {
			list_actual.name = name_entry.text;
			list_actual.start_date = "";
			list_actual.due_date = "";
			list_actual.icon = icon_image;
			list_actual.id_project = settings.get_int ("last-project-id");

			if (edit_bool) {
				db.update_list (list_actual);
				update_list (list_actual);
			} else {
				db.add_list (list_actual);
				created_list ();
			}

			clear_entrys ();
        }

        private void clear_entrys () {

            name_entry.text = "";
            name_entry.grab_focus ();

        }

		public void set_list_to_edit (Interfaces.List list) {
			list_actual = list;

			title_label.label = _("<b>Edit List</b>");
			add_button.label = _("Update");

			name_entry.text = list_actual.name;
			icon_image = list_actual.icon;

			edit_bool = true;
			remove_button.visible = true;
			add_button.sensitive = false;
		}
	}
}
