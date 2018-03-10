namespace Planner {

    public class ProjectList : Gtk.ListBox {

        SqliteDatabase db;

        Gee.ArrayList<Project?> all_projects;

        // Signal to delete a project
        public signal void delete_project (Project project);
        public signal void edit_project (Project project);

        public ProjectList () {

            set_selection_mode (Gtk.SelectionMode.SINGLE);

            set_activate_on_single_click (true);

            db = new SqliteDatabase (true);

            create_list ();

        }

        private void create_list () {

            // get all accounts
            all_projects = new Gee.ArrayList<Project?> ();
            all_projects = db.get_all_projects ();

            foreach (var project in all_projects) {

                var row = new ProjectItem (project);

                add (row);

                connect_row_signals (row);

            }

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

            foreach (Gtk.Widget element in get_children ()) {
                
                remove (element);
            }

            create_list ();

        }
    }
}
