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
}