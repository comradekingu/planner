namespace Planner {

	public class Calendar : Gtk.EventBox {

		private Gtk.Calendar calendar;
		private Gtk.Button left_button;
		private Gtk.Button right_button;
		private Gtk.Button center_button;

		private int min_month;
		private int max_month;

		private Gee.ArrayList<string> name_months = Utils.name_months (); 

		public Calendar (int min, int max) {

			expand = true;

			min_month = min;
			max_month = max;

			build_ui ();
		}

		private void build_ui () {

			var main_grid = new Gtk.Grid ();
        	main_grid.orientation = Gtk.Orientation.VERTICAL;
        	main_grid.column_spacing = 3;
        	main_grid.expand = true;

			calendar = new Gtk.Calendar ();
   			calendar.margin_top = 6;
   			calendar.show_heading = false;
			calendar.expand = true;

   			left_button = new Gtk.Button.from_icon_name ("pan-start-symbolic");
   			left_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            	
            center_button = new Gtk.Button.with_label (new GLib.DateTime.now_local ().format ("%B"));
            center_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            right_button = new Gtk.Button.from_icon_name ("pan-end-symbolic");
            right_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            left_button.clicked.connect ( () => {

            	calendar.month = calendar.month - 1;

            	if (calendar.month < min_month) {

            		calendar.month = min_month;

            	}

            	center_button.label = name_months[calendar.month];

            });
            
            center_button.clicked.connect ( () => {

            	var date =  new GLib.DateTime.now_local ();

            	center_button.label = date.format ("%B");

            	calendar.month = date.get_month ();

            });
            
            right_button.clicked.connect ( () => {

            	calendar.month = calendar.month + 1;

            	if (calendar.month > max_month) {

            		calendar.month = max_month;

            	}

            	center_button.label = name_months[calendar.month];

            });

            left_button.can_focus = false;
            center_button.can_focus = false;
            right_button.can_focus = false;
           
            var control_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            control_box.add (left_button);

            control_box.pack_end (right_button, false, false, 6);
            control_box.pack_end (center_button, true, true, 6);


            control_box.set_size_request (-1, 30);

            main_grid.add (control_box);
            main_grid.add (calendar);

            add (main_grid);
		}

	}
}