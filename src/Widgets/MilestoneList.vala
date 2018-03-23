namespace Planner {
	public class MilestoneList : Gtk.Grid {

		private Gtk.Label title_label;
		private Gtk.Button add_button;
		private Gtk.LevelBar levelbar;
        private Gtk.ListBox milestone_list;

		private NewListPopover new_list_popover;
        private Gtk.ScrolledWindow list_scrolled_window;


		public MilestoneList () {

			orientation = Gtk.Orientation.VERTICAL;
            column_spacing = 12;
            margin = 25;
            margin_top = 50;
            margin_bottom = 50;
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
            add_button.clicked.connect ( () => {

            	new_list_popover.show_all ();

            });

            new_list_popover = new NewListPopover (add_button, true);

            var title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            title_box.pack_start (title_label, false, false, 0);
            title_box.pack_end (add_button, false, false, 0);

            levelbar = new Gtk.LevelBar.for_interval (0, 100.0);
            levelbar.value = 70.5;
            levelbar.margin_top = 12;
            levelbar.hexpand = true;

            milestone_list = new Gtk.ListBox ();
            milestone_list.margin_top = 12;
            milestone_list.activate_on_single_click = true;
            milestone_list.selection_mode = Gtk.SelectionMode.SINGLE;
            
            
            milestone_list.add (new ListMilestoneRow ());
            milestone_list.add (new ListMilestoneRow ());
            milestone_list.add (new ListMilestoneRow ());
            milestone_list.add (new ListMilestoneRow ());
            milestone_list.add (new ListMilestoneRow ());
            milestone_list.add (new ListMilestoneRow ());


            list_scrolled_window = new Gtk.ScrolledWindow (null, null);
            list_scrolled_window.expand = true;
            list_scrolled_window.margin_top = 12;
            list_scrolled_window.add (milestone_list);

            

            add (title_box);
            add (levelbar);
            add (list_scrolled_window);
		}
	}
}