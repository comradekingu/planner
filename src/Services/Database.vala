namespace Planner { 
    
    public class SqliteDatabase : GLib.Object {
        
        private Sqlite.Database db;
        private string db_path;

        public SqliteDatabase (bool skip_tables = false) {
            
            int rc = 0;

            this.db_path = Environment.get_home_dir () + "/.local/share/planner/planner.db";

            if (!skip_tables) {
                if (create_tables () != Sqlite.OK) {
                    stderr.printf ("Error creating db table: %d, %s\n", rc, this.db.errmsg ());
                    Gtk.main_quit ();
                }
            }

            rc = Sqlite.Database.open (this.db_path, out this.db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, this.db.errmsg ());
                Gtk.main_quit ();
            }
        }

        private int create_tables () {
            
            int rc;

            rc = Sqlite.Database.open (this.db_path, out this.db);
            
            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, this.db.errmsg ());
                Gtk.main_quit ();
            }

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS PROJECTS (id_project INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "description VARCHAR," +
            "start_date DATE," +
            "final_date DATE," +
            "avatar VARCHAR)", null, null);

            debug ("Table projects created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS LISTS (id_list INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "start_date DATE," +
            "final_date DATE," +
            "progress INTEGER," +
            "id_project INTEGER," + 
            "FOREIGN KEY(id_project) REFERENCES PROJECTS(id_project))", null, null);

            debug ("Table lists created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS TASKS (id_task INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "state VARCHAR," +
            "deadline DATE," +
            "priority VARCHAR," +
            "id_list INTEGER," + 
            "FOREIGN KEY(id_list) REFERENCES LISTS(id_list))", null, null);

            debug ("Table tasks created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS CONTACTS (id_contact INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "position VARCHAR," +
            "email VARCHAR," +
            "phone VARCHAR," +
            "photo VARCHAR," +
            "address VARCHAR," +
            "id_project INTEGER," + 
            "FOREIGN KEY(id_project) REFERENCES PROJECTS(id_project))", null, null);
            
            debug ("Table contacts created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS ASSIGNED (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "id_contact INTEGER," +
            "id_task INTEGER," +
            "FOREIGN KEY(id_contact) REFERENCES CONTACTS(id_contact)," +
            "FOREIGN KEY(id_task) REFERENCES TASKS(id_task))", null, null);
            
            debug ("Table assigned created");

            return rc;
        }
    }
}