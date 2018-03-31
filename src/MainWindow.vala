namespace Planner {
    public class MainWindow : Gtk.Window {

        private Headerbar headerbar;
        private Gtk.Stack main_stack;

        private WelcomeView welcome_view;
        private ProjectStartupView startup_view;
        private OverviewView overview_view;
        private TaskView task_view;
        private IssuesView issues_view;

        private SqliteDatabase db;
        private GLib.Settings settings;

        public MainWindow (Gtk.Application application) {

            Object (
                application: application,
                icon_name: "com.github.alainm23.planner",
                title: "Planner"
            );

            
            settings = new GLib.Settings ("com.github.alainm23.planner");


            //Gtk.Settings.get_default().set("gtk-application-prefer-dark-theme", true);
            
            var window_x = settings.get_int ("window-x");
            var window_y = settings.get_int ("window-y");
            move (window_x, window_y);

            var window_width = settings.get_int ("window-width");
            var window_height = settings.get_int ("window-height");
            set_default_size (window_width, window_height);

            // Icons Theme
            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/alainm23/planner");


            // Create folder and .sqlite db
            Utils.create_dir_with_parents ("/.local/share/planner");
            db = new SqliteDatabase ();
            

            build_ui ();

            this.delete_event.connect ( () => {

                int current_x, current_y, width, height;
                get_position (out current_x, out current_y);
                get_size (out width, out height);

                settings.set_int ("window-width", width);
                settings.set_int ("window-height", height);
                settings.set_int ("window-x", current_x);
                settings.set_int ("window-y", current_y);

                return false;
            });
        }

        public void build_ui () {

            main_stack = new Gtk.Stack ();
            main_stack.transition_duration = 400;
            main_stack.vexpand = true;
            main_stack.hexpand = true;
            main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;

            // Welcome View
            welcome_view = new WelcomeView ();
            //main_stack.set_visible_child_name ("welcome_view");
            
            // Overview
            overview_view = new OverviewView ();

            // Task View
            task_view = new TaskView ();

            // Issues View
            issues_view = new IssuesView ();

            // StartUp View
            startup_view = new ProjectStartupView ();

            // Headerbar
            headerbar = new Headerbar ();
            set_titlebar (headerbar);
            headerbar.update_project.connect (update_project);
            headerbar.on_headerbar_change.connect ( (name_bar) => {

                if (name_bar == "Overview") {

                    main_stack.visible_child_name = "overview_view";
                
                } else if (name_bar == "Tasks") {
                
                    main_stack.visible_child_name = "task_view";
                
                } else if (name_bar == "Issues") {
                
                    main_stack.visible_child_name = "issues_view";        
                
                }
                    
            });
            
            startup_view.on_cancel_button.connect ( () => {

                main_stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                main_stack.visible_child_name = "welcome_view";
            
            });

            startup_view.on_create_button.connect ( (project) => {

                db.add_project (project);
                
                headerbar.enable_all (); 
                headerbar.set_project (project);

                settings.set_int ("last-project-id", 1);

                main_stack.visible_child_name = "overview_view";

            });

            welcome_view.on_welcome_select.connect ( (index) => {

                if (index == 0) {
                    main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
                    main_stack.visible_child_name = "startup_view";
                }
                
            });
            
            main_stack.add_named (overview_view, "overview_view");
            main_stack.add_named (startup_view, "startup_view");
            main_stack.add_named (welcome_view, "welcome_view");
            main_stack.add_named (task_view, "task_view");
            main_stack.add_named (issues_view, "issues_view");

            add (main_stack); 

            show_all ();

            if (db.get_project_number () < 1) {

                headerbar.disable_all ();

                main_stack.visible_child_name = "welcome_view";   

            } else {

                int id = settings.get_int ("last-project-id");

                Gee.ArrayList<Project?> all_projects = new Gee.ArrayList<Project?> ();
                all_projects = db.get_all_projects ();


                foreach (var project in all_projects) {
                    if (project.id == id.to_string ())
                        headerbar.set_project (project);
                }

                main_stack.visible_child_name = "overview_view";
            }
        }

        private void update_project (Project project) {

            settings.set_int ("last-project-id", int.parse(project.id));
            task_view.update_widget (); 
                
        }
    }
}