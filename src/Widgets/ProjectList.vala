namespace Planner { 
    public class ProjectList : Gtk.ListBox {

        public MainWindow window { get; construct; }
        
        SqliteDatabase db;
        List<Project?> all_projects;

        public signal void project_delete (string key);

        public ProjectList () {

            set_selection_mode (Gtk.SelectionMode.SINGLE);

            set_activate_on_single_click (true);

            db = new SqliteDatabase (true);


            create_list ();
            
        }
            
        public void create_list () {

            // get all accounts
            all_projects = new List<Project?> ();
            all_projects = this.db.get_all_projects ();

            foreach (var project in all_projects) {
                
                this.add (new ProjectItem (project.name, project.description, project.logo));
            
            }       
        }
    }
}