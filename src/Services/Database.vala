namespace Planner {

    public class SqliteDatabase : GLib.Object {

        private Sqlite.Database db;
        private string db_path;

        public SqliteDatabase (bool skip_tables = false) {

            int rc = 0;

            db_path = Environment.get_home_dir () + "/.local/share/planner/planner.db";

            if (!skip_tables) {
                if (create_tables () != Sqlite.OK) {
                    stderr.printf ("Error creating db table: %d, %s\n", rc, db.errmsg ());
                    Gtk.main_quit ();
                }
            }

            rc = Sqlite.Database.open (db_path, out db);

            rc = db.exec ("PRAGMA foreign_keys=ON");

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }
        }

        private int create_tables () {

            int rc;

            rc = Sqlite.Database.open (db_path, out db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS PROJECTS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "description VARCHAR," +
            "start_date DATE," +
            "due_date DATE," +
            "type VARCHAR, " +
            "avatar VARCHAR)", null, null);
            
            debug ("Table projects created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS LISTS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "start_date DATE," +
            "due_date DATE," +
            "icon VARCHAR," +
            "id_project INTEGER," + 
            "FOREIGN KEY(id_project) REFERENCES PROJECTS(id))", null, null);
            
            debug ("Table lists created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS TASKS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "state VARCHAR," +
            "deadline DATE," +
            "priority VARCHAR," +
            "note VARCHAR," +
            "id_list INTEGER," +
            "FOREIGN KEY(id_list) REFERENCES LISTS(id_list))", null, null);
            
            debug ("Table tasks created");

            rc = this.db.exec ("CREATE TABLE IF NOT EXISTS CONTACTS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "role VARCHAR," +
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

            rc = this.db.exec ("PRAGMA foreign_keys=ON");

            return rc;
        }

        public void add_project (Project project) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("INSERT INTO PROJECTS (name, " +
                "description, start_date, due_date, type, avatar)" +
                "VALUES (?, ?, ?, ?, ?, ?)", -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, project.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, project.description);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, project.start_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, project.due_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (5, project.type);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (6, project.avatar);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.DONE) {
                debug ("Project " + project.name + " created");
            }
        }

        public void add_list (List list) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("INSERT INTO LISTS (name, " +
                "start_date, due_date, icon, id_project)" +
                "VALUES (?, ?, ?, ?, ?)", -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, list.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, list.start_date);
            assert (res == Sqlite.OK);
            
            res = stmt.bind_text (3, list.due_date);
            assert (res == Sqlite.OK);
            
            res = stmt.bind_text (4, list.icon);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (5, list.id_project);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.DONE) {

                debug ("List " + list.name + " created");
            }

            stdout.printf(list.name + "\n");
            stdout.printf(list.icon + "\n");
            stdout.printf(list.id_project.to_string () + "\n");
            stdout.printf("Lista Creada \n");

        }

        public void remove_project ( Project project) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("DELETE FROM PROJECTS " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, project.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Project removed: " + project.name);

        }

        public void update_project (Project project) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("UPDATE PROJECTS SET name = ?, " +
                "description = ?, start_date = ?, due_date = ?, type = ?, avatar = ? " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, project.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, project.description);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, project.start_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, project.due_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (5, project.type);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (6, project.avatar);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (7, project.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Project updated: " + project.name);
        }

        public Gee.ArrayList<List?> get_all_lists (int id_project) {

            Sqlite.Statement stmt;
            int res = db.prepare_v2 ("SELECT * FROM LISTS where id_project = ? ORDER BY id",
                -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, id_project);
            assert (res == Sqlite.OK);
        
            Gee.ArrayList<List?> all = new Gee.ArrayList<List?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {

                List list = new List ();

                list.id = int.parse(stmt.column_text (0));
                list.name = stmt.column_text (1);
                list.start_date = stmt.column_text (2);
                list.due_date = stmt.column_text (3);
                list.icon = stmt.column_text (4);
                list.id_project = int.parse(stmt.column_text (5));

                all.add (list);
                
            }

            return all;
        }   


        public Gee.ArrayList<Project?> get_all_projects () {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("SELECT * FROM PROJECTS ORDER BY id",
            -1, out stmt);

            assert (res == Sqlite.OK);

            Gee.ArrayList<Project?> all = new Gee.ArrayList<Project?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {

                Project project = new Project ();

                project.id = stmt.column_text (0);
                project.name = stmt.column_text (1);
                project.description = stmt.column_text (2);
                project.start_date = stmt.column_text (3);
                project.due_date = stmt.column_text (4);
                project.type = stmt.column_text (5);
                project.avatar = stmt.column_text (6);

                all.add (project);
            }

            return all;
        }

        public int get_project_number () {

            var all_projects = new Gee.ArrayList<Project?> ();
            all_projects = get_all_projects ();

            return all_projects.size;
        }
    }
}
