/*
* Copyright (c) 2018 Alain M. (https://github.com/alainm23/planner)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alain M. <alain23@protonmail.com>
*/

namespace Planner {
    public class Services.Database : GLib.Object {
        private Sqlite.Database db;
        private string db_path;

        public Database (bool skip_tables = false) {

            int rc = 0;

            db_path = Environment.get_home_dir () + "/.local/share/com.github.alainm23.planner/planner.db";

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
        }

        private int create_tables () {
            int rc;

            rc = Sqlite.Database.open (db_path, out db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }

            rc = db.exec ("CREATE TABLE IF NOT EXISTS PROJECTS (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name VARCHAR, " +
                "description VARCHAR, " +
                "start_date DATE, " +
                "final_date DATE, " +
                "last_update DATE, " +
                "note VARCHAR, " +
                "avatar VARCHAR)", null, null);
            debug ("Table PROJECTS created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS MILESTONES (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name VARCHAR, " +
                "note VARCHAR, " +
                "color VARCHAR, " +
                "avatar VARCHAR, " +
                "id_project INTEGER, " +
                "FOREIGN KEY(id_project) REFERENCES PROJECTS(id) ON DELETE CASCADE)", null, null);
            debug ("Table LISTS created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS TAGS (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "name VARCHAR, " +
                "description VARCHAR, " +
                "color VARCHAR, " +
                "id_project INTEGER, " +
                "FOREIGN KEY(id_project) REFERENCES PROJECTS(id) ON DELETE CASCADE)", null, null);
            debug ("Table TAGS created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS TASKS (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "name VARCHAR," +
                "state VARCHAR," +
                "deadline DATETIME," +
                "note VARCHAR," +
                "id_project INTEGER," +
                "id_milestone INTEGER," +
                "FOREIGN KEY(id_milestone) REFERENCES MILESTONES(id), " +
                "FOREIGN KEY(id_project) REFERENCES PROJECTS(id) ON DELETE CASCADE)", null, null);
            debug ("Table TASKS created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS TASKS_TAGS (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "id_tag INTEGER, " +
                "id_task INTEGER, " +
                "FOREIGN KEY(id_tag) REFERENCES TAGS(id) ON DELETE CASCADE, " +
                "FOREIGN KEY(id_task) REFERENCES TASKS(id) ON DELETE CASCADE)", null, null);
            debug ("Table TASKS_TAGS created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS CONTACTS (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "name VARCHAR, " +
                "role VARCHAR, " +
                "email VARCHAR, " +
                "phone VARCHAR, " +
                "photo VARCHAR, " +
                "address VARCHAR, " +
                "id_project INTEGER, " +
                "FOREIGN KEY(id_project) REFERENCES PROJECTS(id) ON DELETE CASCADE)", null, null);
            debug ("Table CONTACTS created");

            rc = db.exec ("CREATE TABLE IF NOT EXISTS SUBTASKS (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name VARCHAR, " +
                "state VARCHAR, " +
                "id_task INTEGER, " +
                "FOREIGN KEY(id_task) REFERENCES TASKS(id) ON DELETE CASCADE)", null, null);
            debug ("Table SUBTASKS created");

            string errormsg;
            if (db.exec ("PRAGMA foreign_keys = ON;", null, out errormsg) != Sqlite.OK) {
                warning (errormsg);
            }

            return rc;
        }

        public void add_project (Objects.Project project) {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("INSERT INTO PROJECTS (name, " +
                "description, start_date, final_date, last_update, note, avatar)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)", -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, project.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, project.description);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, project.start_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, project.final_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (5, project.last_update);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (6, project.note);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (7, project.avatar);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.DONE) {
                debug ("Project " + project.name + " created");
            }
        }
        public Gee.ArrayList<Objects.Project?> get_all_projects () {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("SELECT * FROM PROJECTS ORDER BY id",
                -1, out stmt);

            assert (res == Sqlite.OK);

            var all = new Gee.ArrayList<Objects.Project?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {
                var project = new Objects.Project ();

                project.id = int.parse (stmt.column_text (0));
                project.name = stmt.column_text (1);
                project.description = stmt.column_text (2);
                project.start_date = stmt.column_text (3);
                project.final_date = stmt.column_text (4);
                project.last_update = stmt.column_text (5);
                project.note = stmt.column_text (6);
                project.avatar = stmt.column_text (7);

                all.add (project);
            }
            return all;
        }
        public void update_project (Objects.Project project) {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("UPDATE PROJECTS SET name = ?, " +
                "description = ?, start_date = ?, final_date = ?, last_update = ?, note = ?, avatar = ? " +
                "WHERE id = ?", -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, project.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, project.description);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, project.start_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, project.final_date);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (5, project.last_update);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (6, project.note);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (7, project.avatar);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (8, project.id);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.OK)
                debug ("Project updated: " + project.name);
        }

        public Objects.Project get_project (int id) {
            Sqlite.Statement stmt;
            int res = db.prepare_v2 ("SELECT * FROM PROJECTS WHERE id = ?",
                -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, id);
            assert (res == Sqlite.OK);

            stmt.step ();

            var project = new Objects.Project ();

            project.id = int.parse (stmt.column_text (0));
            project.name = stmt.column_text (1);
            project.description = stmt.column_text (2);
            project.start_date = stmt.column_text (3);
            project.final_date = stmt.column_text (4);
            project.last_update = stmt.column_text (5);
            project.note = stmt.column_text (6);
            project.avatar = stmt.column_text (7);

            return project;
        }

        public void remove_project (Objects.Project project) {
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

        public void add_task (Objects.Task task) {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("INSERT INTO TASKS (name, " +
                "note, state, deadline, id_project)" +
                "VALUES (?, ?, ?, ?, ?)", -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, task.name);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, task.note);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (3, task.state);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (4, task.deadline);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (5, task.id_project);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.DONE) {
                debug ("task " + task.name + " created");
            }
        }
        public Gee.ArrayList<Objects.Task?> get_all_tasks (int project_id) {
            Sqlite.Statement stmt;
            int res = db.prepare_v2 ("SELECT * FROM TASKS where id_project = ? ORDER BY id",
                -1, out stmt);
            assert (res == Sqlite.OK);

            res = stmt.bind_int (1, project_id);
            assert (res == Sqlite.OK);

            var all = new Gee.ArrayList<Objects.Task?> ();

            while ((res = stmt.step()) == Sqlite.ROW) {
                var task = new Objects.Task ();

                task.id = stmt.column_int (0);
                task.name = stmt.column_text (1);
                task.state = stmt.column_text (2);
                task.deadline = stmt.column_text (3);
                task.note = stmt.column_text (4);
                task.id_project = stmt.column_int (5);

                all.add (task);
            }

            return all;
        }
    }
}
