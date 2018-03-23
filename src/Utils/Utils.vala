namespace Planner.Utils {
    
    // creates a directory with all needed parents, relative to home

    public void create_dir_with_parents (string dir) {
    
        string path = Environment.get_home_dir () + dir;
        File tmp = File.new_for_path (path);
        if (tmp.query_file_type (0) != FileType.DIRECTORY) {    
            GLib.DirUtils.create_with_parents (path, 0775);
        }
    }

    public bool exists_database () {

        string path = Environment.get_home_dir () + "/.local/share/planner/planner.db";

        File file = File.new_for_path (path);
        
        bool tmp = file.query_exists ();
        
        return tmp;

    }

    public Gee.ArrayList<string> project_types () {

        var project_types = new Gee.ArrayList<string> ();

        project_types.add ("planner-startup");       // 0
        project_types.add ("planner-checklist");     // 1
        project_types.add ("planner-computer");      // 2
        project_types.add ("planner-code");          // 3
        project_types.add ("planner-pen");           // 4
        project_types.add ("planner-web");           // 5
        project_types.add ("planner-video-player");  // 6
        project_types.add ("planner-online-shop");   // 7
        project_types.add ("planner-team");          // 8
    
        return project_types;
    }

    public Gee.ArrayList<string> name_months () {

        var name_months = new Gee.ArrayList<string> ();

        name_months.add (_("January"));
        name_months.add (_("February"));
        name_months.add (_("March"));
        name_months.add (_("April"));
        name_months.add (_("May"));
        name_months.add (_("June"));
        name_months.add (_("July"));
        name_months.add (_("August"));
        name_months.add (_("September"));
        name_months.add (_("October"));
        name_months.add (_("November"));
        name_months.add (_("December"));

        return name_months;

    }
}