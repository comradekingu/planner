namespace Planner {
	public class MilestoneList : Gtk.Grid {

		private Gtk.Label title_label;
		private Gtk.Button add_button;
		private Gtk.LevelBar levelbar;
        private Gtk.ListBox milestone_list;

		private NewListPopover new_list_popover;
        private Gtk.ScrolledWindow list_scrolled_window;

        private Services.Database db;
        private GLib.Settings settings;

        public signal void list_selected (Interfaces.List list);

		public MilestoneList () {

            db = new Services.Database (true);
            settings = new GLib.Settings ("com.github.alainm23.planner");

			orientation = Gtk.Orientation.VERTICAL;
            row_spacing = 12;
            margin = 50;
            expand = true;

			build_ui ();
		}

		private void build_ui () {

			title_label = new Gtk.Label ("<b>Milestones</b>");
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.halign = Gtk.Align.START;
            title_label.use_markup = true;

            add_button = new Gtk.Button.from_icon_name("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            add_button.tooltip_text = _("Create a new Milestone");
            add_button.halign = Gtk.Align.END;
            add_button.valign = Gtk.Align.CENTER;
            add_button.margin_end = 6;
            add_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            add_button.clicked.connect ( () => {

            	new_list_popover.show_all ();

            });

            new_list_popover = new NewListPopover (add_button, true);
            new_list_popover.created_list.connect ( () => {

                update_list ();

            });

            var title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            title_box.pack_start (title_label, false, false, 0);
            title_box.pack_end (add_button, false, false, 0);

            levelbar = new Gtk.LevelBar.for_interval (0, 100.0);
            levelbar.value = 70.5;
            levelbar.margin_end = 6;
            levelbar.hexpand = true;


            milestone_list = new Gtk.ListBox ();
            //milestone_list.margin_top = 12;
            milestone_list.activate_on_single_click = true;
            milestone_list.selection_mode = Gtk.SelectionMode.NONE;

            list_scrolled_window = new Gtk.ScrolledWindow (null, null);
            list_scrolled_window.expand = true;
            list_scrolled_window.add (milestone_list);

            create_list ();
            
            add (title_box);
            add (levelbar);
            add (list_scrolled_window);
		
        }

        private void create_list () {

            var all_list = new Gee.ArrayList<Interfaces.List?> ();
            all_list = db.get_all_lists (settings.get_int ("last-project-id"));

            foreach (var list in all_list) {
                    
                var row = new ListMilestoneRow (list);

                milestone_list.add (row);

                row.selected_list.connect (selected_list);
            }

            show_all ();
        }

        public void update_list () {

            foreach (Gtk.Widget element in milestone_list.get_children ()) {
                
                milestone_list.remove (element);
            }

            create_list ();
            
            selected_list (new Interfaces.List());
	   }

        private void selected_list (Interfaces.List list) {
            
            list_selected (list);
        
        }
    }
}