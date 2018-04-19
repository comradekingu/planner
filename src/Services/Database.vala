namespace Planner {

    public class Services.Database : GLib.Object {

        private Sqlite.Database db;
        private string db_path;
        private GLib.Settings settings;

        public Database (bool skip_tables = false) {

            int rc = 0;

            db_path = Environment.get_home_dir () + "/.local/share/com.github.alainm23.planner/database.db";

            if (!skip_tables) {
                if (create_tables () != Sqlite.OK) {
                    stderr.printf ("Error creating db table: %d, %s\n", rc, db.errmsg ());
                    Gtk.main_quit ();
                }
            }

            rc = Sqlite.Database.open (db_path, out db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }

            settings = new GLib.Settings ("com.github.alainm23.planner");
        }

        private int create_tables () {

            int rc;

            rc = Sqlite.Database.open (db_path, out db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }

            rc = db.exec ("CREATE TABLE IF NOT EXISTS PROJECTS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "description VARCHAR," +
            "start_date DATE," +
            "due_date DATE," +
            "type VARCHAR, " +
            "avatar VARCHAR)", null, null);

            debug ("Table projects created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS LISTS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "start_date DATE," +
            "due_date DATE," +
            "icon VARCHAR," +
            "id_project INTEGER," +
            "FOREIGN KEY(id_project) REFERENCES PROJECTS(id) ON DELETE CASCADE)", null, null);

            debug ("Table lists created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS TASKS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "state VARCHAR," +
            "deadline DATE," +
            "priority VARCHAR," +
            "note VARCHAR," +
            "id_list INTEGER," +
            "FOREIGN KEY(id_list) REFERENCES LISTS(id_list) ON DELETE CASCADE)", null, null);

            debug ("Table tasks created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS CONTACTS (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "name VARCHAR," +
            "role VARCHAR," +
            "email VARCHAR," +
            "phone VARCHAR," +
            "photo VARCHAR," +
            "address VARCHAR," +
            "id_project INTEGER," +
            "FOREIGN KEY(id_project) REFERENCES PROJECTS(id_project) ON DELETE CASCADE)", null, null);

            debug ("Table contacts created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS ASSIGNED (id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "id_contact INTEGER," +
            "id_task INTEGER," +
            "FOREIGN KEY(id_contact) REFERENCES CONTACTS(id_contact) ON DELETE CASCADE," +
            "FOREIGN KEY(id_task) REFERENCES TASKS(id_task) ON DELETE CASCADE)", null, null);

            debug ("Table assigned created");

            rc = db.exec ("PRAGMA foreign_keys = ON");

            return rc;
        }

        public void add_project (Interfaces.Project project) {

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

        public void add_list (Interfaces.List list) {

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
        }

        public void add_task (Interfaces.Task task) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("INSERT INTO TASKS (name, " +
                "state, deadline, priority, note, id_list)" +
                "VALUES (?, ?, ?, ?, ?, ?)", -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, task.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, task.state);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, task.deadline);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, task.priority);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (5, task.note);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (6, task.id_list);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.DONE) {

                debug ("task " + task.name + " created");
            }
        }

        public void remove_project (Interfaces.Project project) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("DELETE FROM PROJECTS " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, project.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Project removed: " + project.name);

        }

        public void remove_task (Interfaces.Task task) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("DELETE FROM TASKS " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, task.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Task removed: " + task.name);
        }

        public void remove_list (Interfaces.List list) {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("DELETE FROM LISTS " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, list.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("List removed: " + list.name);

        }

        public void update_project (Interfaces.Project project) {
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

            res = stmt.bind_int (7, project.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Project updated: " + project.name);
        }

        public void update_task (Interfaces.Task task) {

            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("UPDATE TASKS SET name = ?, " +
                "state = ?, deadline = ?, priority = ?, note = ? " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, task.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, task.state);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, task.deadline);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, task.priority);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (5, task.note);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (6, task.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Task updated: " + task.name);
        }

        public void update_list (Interfaces.List list) {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("UPDATE LISTS SET name = ?, icon = ? " +
            "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, list.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, list.icon);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (3, list.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("List updated: " + list.name);
        }

        public Gee.ArrayList<Interfaces.List?> get_all_lists (int id_project) {

            Sqlite.Statement stmt;
            int tasks_completed = 0;

            int res = db.prepare_v2 ("SELECT * FROM LISTS where id_project = ? ORDER BY id",
                -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, id_project);
            assert (res == Sqlite.OK);

            var all = new Gee.ArrayList<Interfaces.List?> ();
            var all_tasks = new Gee.ArrayList<Interfaces.Task?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {
                Interfaces.List list = new Interfaces.List ();

                list.id = int.parse(stmt.column_text (0));
                list.name = stmt.column_text (1);
                list.start_date = stmt.column_text (2);
                list.due_date = stmt.column_text (3);
                list.icon = stmt.column_text (4);
                list.id_project = int.parse(stmt.column_text (5));

                all_tasks = get_all_tasks (list.id);
                list.task_all = all_tasks.size;

                foreach (var task in all_tasks) {
                    if (task.state == "true") {
                        tasks_completed = tasks_completed + 1;
                    }
                }
                list.tasks_completed = tasks_completed;

                all.add (list);
                tasks_completed = 0;
            }

            return all;
        }

        public Gee.ArrayList<Interfaces.Project?> get_all_projects () {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("SELECT * FROM PROJECTS ORDER BY id",
                -1, out stmt);

            assert (res == Sqlite.OK);

            var all = new Gee.ArrayList<Interfaces.Project?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {
                var project = new Interfaces.Project ();

                project.id = int.parse (stmt.column_text (0));
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

        public Gee.ArrayList<Interfaces.Task?> get_all_tasks (int id_list=1) {

            Sqlite.Statement stmt;
            int res = db.prepare_v2 ("SELECT * FROM TASKS where id_list = ? ORDER BY id",
                -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, id_list);
            assert (res == Sqlite.OK);

            var all = new Gee.ArrayList<Interfaces.Task?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {

                var task = new Interfaces.Task ();

                task.id = stmt.column_int (0);
                task.name = stmt.column_text (1);
                task.state = stmt.column_text (2);
                task.deadline = stmt.column_text (3);
                task.priority = stmt.column_text (4);
                task.note = stmt.column_text (5);
                task.id_list = stmt.column_int (6);

                all.add (task);
            }

            return all;
        }

        public int get_project_number () {
            var all_projects = new Gee.ArrayList<Interfaces.Project?> ();
            all_projects = get_all_projects ();

            return all_projects.size;
        }

        public int get_list_length () {
            var all_lists = new Gee.ArrayList<Interfaces.List?> ();
            all_lists = get_all_lists (settings.get_int ("last-project-id"));

            return all_lists.size;
        }

        public int get_tasks_length  (int list_id) {
            var all_tasks = new Gee.ArrayList<Interfaces.Task?> ();
            all_tasks = get_all_tasks (list_id);

            return all_tasks.size;
        }
    }
}
