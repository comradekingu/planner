namespace Planner {
	
	public class NewListPopover : Gtk.Popover {

		private Calendar calendar;
		private Gtk.Entry name_entry;
		private bool show_calendar = false;

		public NewListPopover (Gtk.Widget relative, bool calendar = false) {
			
			GLib.Object (

                modal: true,
                position: Gtk.PositionType.BOTTOM,
                relative_to: relative
            );

            show_calendar = calendar;
		}

		construct {

			var main_grid = new Gtk.Grid ();
        	main_grid.orientation = Gtk.Orientation.VERTICAL;
        	main_grid.column_spacing = 3;
        	main_grid.margin = 12;
        	main_grid.expand = true;
        	main_grid.width_request = 250;
            //main_grid.set_size_request(250, 300);

            var title_label = new Gtk.Label (_("<b>New List</b>"));
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        	title_label.use_markup = true;

        	var add_button = new Gtk.Button.with_label (_("Save"));
            add_button.tooltip_text = _("Create a new Milestone");
            add_button.halign = Gtk.Align.END;
            add_button.valign = Gtk.Align.CENTER;
            add_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            add_button.clicked.connect ( () => {

            	hide ();

            });

            this.closed.connect ( () => {

                name_entry.grab_focus ();
                name_entry.text = "";
            
            });

            var title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            title_box.hexpand = true;

            name_entry = new Gtk.Entry ();
            name_entry.margin_top = 12;
            name_entry.max_length = 36;
            name_entry.placeholder_text = _("Name");

            var deadline_label = new Granite.HeaderLabel (_("Deadline"));

        	deadline_label.margin_top = 12;
   			
   			calendar = new Calendar (0, 12);

            title_box.pack_start (title_label, false, true, 0);
            title_box.pack_end (add_button, false, true, 0);

            main_grid.add (title_box);
            main_grid.add (name_entry);
            main_grid.add (deadline_label);
            main_grid.add (calendar);

            add (main_grid);

            name_entry.grab_focus ();
		}
	}
}