namespace Planner {
	public class LogoPopover : Gtk.Popover {

		public signal void on_image_select (string name_icon);
        
		public LogoPopover (Gtk.Widget relative) {

			GLib.Object (

                modal: true,
                position: Gtk.PositionType.RIGHT,
                relative_to: relative

            );
		}

		construct {
            	
        	var main_grid = new Gtk.Grid ();
        	main_grid.orientation = Gtk.Orientation.VERTICAL;
        	main_grid.column_spacing = 3;
            main_grid.row_spacing = 6;
        	main_grid.margin = 12;
            main_grid.set_size_request(250, 300);

		    add (main_grid);

            var title_label = new Gtk.Label (_("Project Avatar"));
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            title_label.halign = Gtk.Align.START;
            title_label.wrap = true;
        	title_label.xalign = 0;
        	title_label.use_markup = true;

        	var icon_entry = new Gtk.Entry ();
        	icon_entry.margin_top = 12;
        	icon_entry.placeholder_text = _("Icon name");
        	icon_entry.primary_icon_name = "edit-find-symbolic";

        	icon_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-all-symbolic");
			icon_entry.icon_press.connect ((pos, event) => {
				if (pos == Gtk.EntryIconPosition.SECONDARY) {
					icon_entry.text = "";
				}
			});


           	var flow_box = new Gtk.FlowBox ();
           	flow_box.activate_on_single_click = true;
            flow_box.column_spacing = 6;
            flow_box.row_spacing = 6;
            flow_box.homogeneous = true;
            flow_box.selection_mode = Gtk.SelectionMode.NONE;

	        var scrolled = new Gtk.ScrolledWindow (null, null);
	        scrolled.margin_top = 12;
	        scrolled.expand = true;
	        scrolled.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
	        scrolled.add (flow_box);

	        // Load Project Icons
	        flow_box.get_children ().@foreach ((child) => {
           		
           		child.destroy ();
       		});

        	foreach (string name in Utils.project_types ()) {

            	var image = new Granite.AsyncImage.from_icon_name_async (name, Gtk.IconSize.DIALOG);
            	flow_box.add (image);
            	flow_box.show_all ();
        	}

        	flow_box.child_activated.connect ( (child) => {

        		flow_box.select_child (child);

        		on_image_select (Utils.project_types()[child.get_index ()]);

        		hide ();
                
        	});

        	icon_entry.activate.connect ( () => {

        		on_image_select (icon_entry.text);

        		hide ();
        	
        	});

        	main_grid.attach (title_label, 0, 0, 1, 1);
        	main_grid.attach (scrolled, 0, 1, 1, 1);	
        	main_grid.attach (icon_entry, 0, 2, 1, 1);

        	icon_entry.grab_focus ();
        }
	}
}