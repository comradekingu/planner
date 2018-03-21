namespace Planner {

    public class ProjectList : Gtk.Grid {

        private Gtk.Button add_button;
        private Gtk.Button search_button;
        private Gtk.Label  title_label; 
        private Gtk.Revealer revealer_searchbar;
        private Gtk.SearchEntry search_entry;
        private Gtk.ListBox project_listbox;
        private Gtk.ScrolledWindow list_scrolled_window;
        
        private Gee.ArrayList<Project?> all_projects;

        private SqliteDatabase db;

        // Signal to delete a project
        public signal void delete_project (Project project);
        public signal void edit_project (Project project);
        public signal void selected_project (Project project);

        public signal void add_project ();

        public ProjectList () {

            db = new SqliteDatabase (true);

            orientation = Gtk.Orientation.VERTICAL;
            column_spacing = 12;
            margin_top = 12;
            margin_right = 12;
            margin_left = 12;
            expand = true;

            buid_ui ();

        }

        private void buid_ui () {

            title_label = new Gtk.Label (_("<b>Projects</b>"));
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.use_markup = true;

            search_button = new Gtk.Button.from_icon_name ("system-search-symbolic", Gtk.IconSize.MENU);
            search_button.tooltip_text = _("Search a project");
            search_button.valign = Gtk.Align.CENTER;
            search_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            add_button = new Gtk.Button.from_icon_name ("folder-new-symbolic", Gtk.IconSize.MENU);
            add_button.tooltip_text = _("Create a new project");
            add_button.valign = Gtk.Align.CENTER;
            add_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            add_button.margin_end = 6;
            add_button.clicked.connect ( () => {

                add_project ();

            });

            var v_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
            v_box.hexpand = true;
            
            v_box.pack_start (title_label, false, true, 0);
            v_box.pack_end (add_button, false, true, 0);
            //v_box.pack_end (search_button, false, true, 0);

            search_entry = new Gtk.SearchEntry ();
            search_entry.no_show_all = true;
            search_entry.margin_top = 12;
            search_entry.placeholder_text = _("Search Projects");
            search_entry.search_changed.connect (apply_filter);

            project_listbox = new Gtk.ListBox ();
            project_listbox.activate_on_single_click = true;
            project_listbox.selection_mode = Gtk.SelectionMode.SINGLE;
            project_listbox.row_activated.connect (on_project_selected);
            project_listbox.set_filter_func (filter_function);

            list_scrolled_window = new Gtk.ScrolledWindow (null, null);
            list_scrolled_window.expand = true;
            list_scrolled_window.margin_top = 12;
            list_scrolled_window.add (project_listbox);

            add (v_box);
            add (search_entry);
            add (list_scrolled_window);

            create_list ();
            
        }

        private void create_list () {

            // get all accounts
            all_projects = new Gee.ArrayList<Project?> ();
            all_projects = db.get_all_projects ();

            foreach (var project in all_projects) {

                var row = new ProjectItem (project);

                project_listbox.add (row);

                connect_row_signals (row);

            }

            add_button.grab_focus ();

            show_all ();
        }

        private void connect_row_signals (ProjectItem row) {

            row.delete_button_active.connect ( (project) => {

                delete_project (project);

            });
            
            row.edit_button_active.connect ( (project) => {

                edit_project (project);

            });
        }
        
        public void update_list () {

            foreach (Gtk.Widget element in project_listbox.get_children ()) {
                
                project_listbox.remove (element);
            }

            create_list ();

        }

        private void on_project_selected (Gtk.ListBoxRow list_box_row) {

            var project_row = list_box_row.get_child () as ProjectItem;

            selected_project (project_row.get_project ());

            update_list ();
        }

        public void activate_search (bool value) {

            search_entry.text = "";

            if (value) {
                
                search_entry.visible = value;   
                search_entry.grab_focus ();
            
            } else {

                search_entry.visible = false;
                add_button.grab_focus ();

            }
        }

        private bool filter_function (Gtk.ListBoxRow list_box_row) {

            var project_row = list_box_row.get_child () as ProjectItem;

            return search_entry.text.down () in project_row.get_project ().name.down ()
                || search_entry.text.down () in project_row.get_project ().description.down ();
        }

        private void apply_filter () {

            project_listbox.set_filter_func (filter_function); 
        }
    }
}
