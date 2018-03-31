namespace Planner {

	public class TaskList : Gtk.Grid {

		private Gtk.Label title_list_label;
		private Gtk.Entry task_entry;
		private Gtk.Image avatar_image;
		/*
		private ListOption state_option;
		private ListOption deadline_option;
		private ListOption delete_option;
		*/
		private Gtk.Button add_button;		

		private Gtk.ListBox task_list;
		private Gtk.ScrolledWindow task_scrolled_window;

		public TaskList () {

			expand = true;
			orientation = Gtk.Orientation.VERTICAL;
            column_spacing = 12;
            margin = 25;
            margin_top = 50;
            margin_bottom = 50;
			width_request = 421;
			
			build_ui ();
		}

		private void build_ui () {

			avatar_image = new Gtk.Image.from_icon_name ("html-symbolic", Gtk.IconSize.DND);
			avatar_image.valign = Gtk.Align.END;

			title_list_label = new Gtk.Label ("<b>List</b>");
			title_list_label.use_markup = true;
			title_list_label.halign = Gtk.Align.START;
			title_list_label.margin_left = 6;
			title_list_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
			/*	
			state_option = new ListOption ("Started", "user-idle");
			state_option.valign = Gtk.Align.END;

			deadline_option = new ListOption ("Deo 12 days", "office-calendar-symbolic");
			deadline_option.valign = Gtk.Align.END;

			delete_option = new ListOption ("Delete", "edit-delete-symbolic");
			delete_option.valign = Gtk.Align.END;
			*/
			add_button = new Gtk.Button.from_icon_name("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            add_button.tooltip_text = _("Create a new Milestone");
            add_button.halign = Gtk.Align.END;
            add_button.valign = Gtk.Align.CENTER;

			var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
			box.hexpand = true;

			//box.pack_start (avatar_image, false, false, 6);
			box.pack_start (title_list_label, false, false, 6);
			//box.pack_start (state_option, false, false, 6);
			//box.pack_start (deadline_option, false, false, 6);
			//box.pack_start (delete_option, false, false, 6);
			box.pack_end (add_button, false, false, 0);

			var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
			//separator.margin_top = 12;

			var stackswitcher = new Granite.Widgets.ModeButton ();
			stackswitcher.margin_top = 12;
			stackswitcher.halign = Gtk.Align.CENTER;
			stackswitcher.width_request = 250;

			stackswitcher.append_text (_("Task"));
			stackswitcher.append_text (_("Completed"));
			stackswitcher.set_active (0);


			task_entry = new Gtk.Entry ();
			task_entry.set_icon_tooltip_text (Gtk.EntryIconPosition.SECONDARY, _("Add to list..."));
			task_entry.max_length = 128;
			task_entry.margin_left = 12;
			task_entry.margin_top = 12;
			
			task_entry.placeholder_text = _("Add new task...");
			task_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
			task_entry.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

			task_entry.changed.connect( () => {

				var str = task_entry.get_text ();
                
                if ( str == "" ) {

                    task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, null);
                
                } else {

                    task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "list-add-symbolic");
                }

			});

			task_entry.activate.connect ( () => {



			});	
			
			task_entry.icon_press.connect ((pos, event) => {
				
				if (pos == Gtk.EntryIconPosition.SECONDARY) {
				

				}
 
			});


			//task_list = new Gtk.ListBox ();
			//task_list.selection_mode = Gtk.SelectionMode.SINGLE;
			var task_grid = new Gtk.Grid ();
			task_grid.orientation = Gtk.Orientation.VERTICAL;

			task_scrolled_window = new Gtk.ScrolledWindow (null, null);
            task_scrolled_window.expand = true;
            task_scrolled_window.margin_top = 12;
            task_scrolled_window.add (task_grid);

			task_grid.add (new TaskListRow ());
			task_grid.add (new TaskListRow ());
			task_grid.add (new TaskListRow ());
			task_grid.add (new TaskListRow ());
			task_grid.add (new TaskListRow ());


			//add (title_list_label);
			add (box);
			//add (separator);
			//add (task_entry);
			//add (stackswitcher);
			add (task_scrolled_window);
			//add (task_entry);
		}
	} 
}