/* Database.c generated by valac 0.36.10, the Vala compiler
 * generated from Database.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <sqlite3.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <gtk/gtk.h>


#define PLANNER_TYPE_SQLITE_DATABASE (planner_sqlite_database_get_type ())
#define PLANNER_SQLITE_DATABASE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), PLANNER_TYPE_SQLITE_DATABASE, PlannerSqliteDatabase))
#define PLANNER_SQLITE_DATABASE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PLANNER_TYPE_SQLITE_DATABASE, PlannerSqliteDatabaseClass))
#define PLANNER_IS_SQLITE_DATABASE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), PLANNER_TYPE_SQLITE_DATABASE))
#define PLANNER_IS_SQLITE_DATABASE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PLANNER_TYPE_SQLITE_DATABASE))
#define PLANNER_SQLITE_DATABASE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PLANNER_TYPE_SQLITE_DATABASE, PlannerSqliteDatabaseClass))

typedef struct _PlannerSqliteDatabase PlannerSqliteDatabase;
typedef struct _PlannerSqliteDatabaseClass PlannerSqliteDatabaseClass;
typedef struct _PlannerSqliteDatabasePrivate PlannerSqliteDatabasePrivate;
#define _sqlite3_close0(var) ((var == NULL) ? NULL : (var = (sqlite3_close (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))

struct _PlannerSqliteDatabase {
	GObject parent_instance;
	PlannerSqliteDatabasePrivate * priv;
};

struct _PlannerSqliteDatabaseClass {
	GObjectClass parent_class;
};

struct _PlannerSqliteDatabasePrivate {
	sqlite3* db;
	gchar* db_path;
};


static gpointer planner_sqlite_database_parent_class = NULL;

GType planner_sqlite_database_get_type (void) G_GNUC_CONST;
#define PLANNER_SQLITE_DATABASE_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), PLANNER_TYPE_SQLITE_DATABASE, PlannerSqliteDatabasePrivate))
enum  {
	PLANNER_SQLITE_DATABASE_0_PROPERTY
};
PlannerSqliteDatabase* planner_sqlite_database_new (gboolean skip_tables);
PlannerSqliteDatabase* planner_sqlite_database_construct (GType object_type, gboolean skip_tables);
static gint planner_sqlite_database_create_tables (PlannerSqliteDatabase* self);
static void planner_sqlite_database_finalize (GObject * obj);


PlannerSqliteDatabase* planner_sqlite_database_construct (GType object_type, gboolean skip_tables) {
	PlannerSqliteDatabase * self = NULL;
	gint rc = 0;
	const gchar* _tmp0_;
	gchar* _tmp1_;
	gboolean _tmp2_;
	const gchar* _tmp8_;
	sqlite3* _tmp9_ = NULL;
	gint _tmp10_;
	gint _tmp11_;
#line 8 "/home/alain/Vala/planner/src/Services/Database.vala"
	self = (PlannerSqliteDatabase*) g_object_new (object_type, NULL);
#line 10 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = 0;
#line 12 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp0_ = g_get_home_dir ();
#line 12 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp1_ = g_strconcat (_tmp0_, "/.local/share/planner/planner.db", NULL);
#line 12 "/home/alain/Vala/planner/src/Services/Database.vala"
	_g_free0 (self->priv->db_path);
#line 12 "/home/alain/Vala/planner/src/Services/Database.vala"
	self->priv->db_path = _tmp1_;
#line 14 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp2_ = skip_tables;
#line 14 "/home/alain/Vala/planner/src/Services/Database.vala"
	if (!_tmp2_) {
#line 82 "Database.c"
		gint _tmp3_;
#line 15 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp3_ = planner_sqlite_database_create_tables (self);
#line 15 "/home/alain/Vala/planner/src/Services/Database.vala"
		if (_tmp3_ != SQLITE_OK) {
#line 88 "Database.c"
			FILE* _tmp4_;
			gint _tmp5_;
			sqlite3* _tmp6_;
			const gchar* _tmp7_;
#line 16 "/home/alain/Vala/planner/src/Services/Database.vala"
			_tmp4_ = stderr;
#line 16 "/home/alain/Vala/planner/src/Services/Database.vala"
			_tmp5_ = rc;
#line 16 "/home/alain/Vala/planner/src/Services/Database.vala"
			_tmp6_ = self->priv->db;
#line 16 "/home/alain/Vala/planner/src/Services/Database.vala"
			_tmp7_ = sqlite3_errmsg (_tmp6_);
#line 16 "/home/alain/Vala/planner/src/Services/Database.vala"
			fprintf (_tmp4_, "Error creating db table: %d, %s\n", _tmp5_, _tmp7_);
#line 17 "/home/alain/Vala/planner/src/Services/Database.vala"
			gtk_main_quit ();
#line 105 "Database.c"
		}
	}
#line 21 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp8_ = self->priv->db_path;
#line 21 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp10_ = sqlite3_open (_tmp8_, &_tmp9_);
#line 21 "/home/alain/Vala/planner/src/Services/Database.vala"
	_sqlite3_close0 (self->priv->db);
#line 21 "/home/alain/Vala/planner/src/Services/Database.vala"
	self->priv->db = _tmp9_;
#line 21 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp10_;
#line 23 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp11_ = rc;
#line 23 "/home/alain/Vala/planner/src/Services/Database.vala"
	if (_tmp11_ != SQLITE_OK) {
#line 122 "Database.c"
		FILE* _tmp12_;
		gint _tmp13_;
		sqlite3* _tmp14_;
		const gchar* _tmp15_;
#line 24 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp12_ = stderr;
#line 24 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp13_ = rc;
#line 24 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp14_ = self->priv->db;
#line 24 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp15_ = sqlite3_errmsg (_tmp14_);
#line 24 "/home/alain/Vala/planner/src/Services/Database.vala"
		fprintf (_tmp12_, "Can't open database: %d, %s\n", _tmp13_, _tmp15_);
#line 25 "/home/alain/Vala/planner/src/Services/Database.vala"
		gtk_main_quit ();
#line 139 "Database.c"
	}
#line 8 "/home/alain/Vala/planner/src/Services/Database.vala"
	return self;
#line 143 "Database.c"
}


PlannerSqliteDatabase* planner_sqlite_database_new (gboolean skip_tables) {
#line 8 "/home/alain/Vala/planner/src/Services/Database.vala"
	return planner_sqlite_database_construct (PLANNER_TYPE_SQLITE_DATABASE, skip_tables);
#line 150 "Database.c"
}


static gint _sqlite3_exec (sqlite3* self, const gchar* sql, sqlite3_callback callback, void* callback_target, gchar* * errmsg) {
	gchar* _vala_errmsg = NULL;
	gint result = 0;
	const gchar* sqlite_errmsg = NULL;
	gint ec = 0;
	const gchar* _tmp0_;
	sqlite3_callback _tmp1_;
	void* _tmp1__target;
	const gchar* _tmp2_ = NULL;
	gint _tmp3_;
	const gchar* _tmp6_;
#line 34 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	g_return_val_if_fail (self != NULL, 0);
#line 34 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	g_return_val_if_fail (sql != NULL, 0);
#line 36 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	_tmp0_ = sql;
#line 36 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	_tmp1_ = callback;
#line 36 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	_tmp1__target = callback_target;
#line 36 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	_tmp3_ = sqlite3_exec (self, _tmp0_, _tmp1_, _tmp1__target, (char**) (&_tmp2_));
#line 36 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	sqlite_errmsg = _tmp2_;
#line 36 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	ec = _tmp3_;
#line 37 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	if ((&_vala_errmsg) != NULL) {
#line 183 "Database.c"
		const gchar* _tmp4_;
		gchar* _tmp5_;
#line 38 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
		_tmp4_ = sqlite_errmsg;
#line 38 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
		_tmp5_ = g_strdup (_tmp4_);
#line 38 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
		_g_free0 (_vala_errmsg);
#line 38 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
		_vala_errmsg = _tmp5_;
#line 194 "Database.c"
	}
#line 40 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	_tmp6_ = sqlite_errmsg;
#line 40 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	sqlite3_free ((void*) _tmp6_);
#line 41 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	result = ec;
#line 41 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	if (errmsg) {
#line 41 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
		*errmsg = _vala_errmsg;
#line 206 "Database.c"
	} else {
#line 41 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
		_g_free0 (_vala_errmsg);
#line 210 "Database.c"
	}
#line 41 "/usr/share/vala-0.36/vapi/sqlite3.vapi"
	return result;
#line 214 "Database.c"
}


static gint planner_sqlite_database_create_tables (PlannerSqliteDatabase* self) {
	gint result = 0;
	gint rc = 0;
	const gchar* _tmp0_;
	sqlite3* _tmp1_ = NULL;
	gint _tmp2_;
	gint _tmp3_;
	sqlite3* _tmp8_;
	gint _tmp9_;
	sqlite3* _tmp10_;
	gint _tmp11_;
	sqlite3* _tmp12_;
	gint _tmp13_;
	sqlite3* _tmp14_;
	gint _tmp15_;
	sqlite3* _tmp16_;
	gint _tmp17_;
#line 29 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_return_val_if_fail (self != NULL, 0);
#line 33 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp0_ = self->priv->db_path;
#line 33 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp2_ = sqlite3_open (_tmp0_, &_tmp1_);
#line 33 "/home/alain/Vala/planner/src/Services/Database.vala"
	_sqlite3_close0 (self->priv->db);
#line 33 "/home/alain/Vala/planner/src/Services/Database.vala"
	self->priv->db = _tmp1_;
#line 33 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp2_;
#line 35 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp3_ = rc;
#line 35 "/home/alain/Vala/planner/src/Services/Database.vala"
	if (_tmp3_ != SQLITE_OK) {
#line 251 "Database.c"
		FILE* _tmp4_;
		gint _tmp5_;
		sqlite3* _tmp6_;
		const gchar* _tmp7_;
#line 36 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp4_ = stderr;
#line 36 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp5_ = rc;
#line 36 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp6_ = self->priv->db;
#line 36 "/home/alain/Vala/planner/src/Services/Database.vala"
		_tmp7_ = sqlite3_errmsg (_tmp6_);
#line 36 "/home/alain/Vala/planner/src/Services/Database.vala"
		fprintf (_tmp4_, "Can't open database: %d, %s\n", _tmp5_, _tmp7_);
#line 37 "/home/alain/Vala/planner/src/Services/Database.vala"
		gtk_main_quit ();
#line 268 "Database.c"
	}
#line 40 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp8_ = self->priv->db;
#line 40 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp9_ = _sqlite3_exec (_tmp8_, "CREATE TABLE IF NOT EXISTS PROJECTS (id_project INTEGER PRIMARY KEY AU" \
"TOINCREMENT," "name VARCHAR," "description VARCHAR," "start_date DATE," "final_date DATE," "avatar VARCHAR)", NULL, NULL, NULL);
#line 40 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp9_;
#line 47 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_debug ("Database.vala:47: Table projects created");
#line 49 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp10_ = self->priv->db;
#line 49 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp11_ = _sqlite3_exec (_tmp10_, "CREATE TABLE IF NOT EXISTS LISTS (id_list INTEGER PRIMARY KEY AUTOINCR" \
"EMENT," "name VARCHAR," "start_date DATE," "final_date DATE," "progress INTEGER," "id_project INTEGER," "FOREIGN KEY(id_project) REFERENCES PROJECTS(id_project))", NULL, NULL, NULL);
#line 49 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp11_;
#line 57 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_debug ("Database.vala:57: Table lists created");
#line 59 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp12_ = self->priv->db;
#line 59 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp13_ = _sqlite3_exec (_tmp12_, "CREATE TABLE IF NOT EXISTS TASKS (id_task INTEGER PRIMARY KEY AUTOINCR" \
"EMENT," "name VARCHAR," "state VARCHAR," "deadline DATE," "priority VARCHAR," "id_list INTEGER," "FOREIGN KEY(id_list) REFERENCES LISTS(id_list))", NULL, NULL, NULL);
#line 59 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp13_;
#line 67 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_debug ("Database.vala:67: Table tasks created");
#line 69 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp14_ = self->priv->db;
#line 69 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp15_ = _sqlite3_exec (_tmp14_, "CREATE TABLE IF NOT EXISTS CONTACTS (id_contact INTEGER PRIMARY KEY AU" \
"TOINCREMENT," "name VARCHAR," "position VARCHAR," "email VARCHAR," "phone VARCHAR," "photo VARCHAR," "address VARCHAR," "id_project INTEGER," "FOREIGN KEY(id_project) REFERENCES PROJECTS(id_project))", NULL, NULL, NULL);
#line 69 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp15_;
#line 79 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_debug ("Database.vala:79: Table contacts created");
#line 81 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp16_ = self->priv->db;
#line 81 "/home/alain/Vala/planner/src/Services/Database.vala"
	_tmp17_ = _sqlite3_exec (_tmp16_, "CREATE TABLE IF NOT EXISTS ASSIGNED (id INTEGER PRIMARY KEY AUTOINCREM" \
"ENT," "id_contact INTEGER," "id_task INTEGER," "FOREIGN KEY(id_contact) REFERENCES CONTACTS(id_contact)," "FOREIGN KEY(id_task) REFERENCES TASKS(id_task))", NULL, NULL, NULL);
#line 81 "/home/alain/Vala/planner/src/Services/Database.vala"
	rc = _tmp17_;
#line 87 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_debug ("Database.vala:87: Table assigned created");
#line 89 "/home/alain/Vala/planner/src/Services/Database.vala"
	result = rc;
#line 89 "/home/alain/Vala/planner/src/Services/Database.vala"
	return result;
#line 314 "Database.c"
}


static void planner_sqlite_database_class_init (PlannerSqliteDatabaseClass * klass) {
#line 3 "/home/alain/Vala/planner/src/Services/Database.vala"
	planner_sqlite_database_parent_class = g_type_class_peek_parent (klass);
#line 3 "/home/alain/Vala/planner/src/Services/Database.vala"
	g_type_class_add_private (klass, sizeof (PlannerSqliteDatabasePrivate));
#line 3 "/home/alain/Vala/planner/src/Services/Database.vala"
	G_OBJECT_CLASS (klass)->finalize = planner_sqlite_database_finalize;
#line 325 "Database.c"
}


static void planner_sqlite_database_instance_init (PlannerSqliteDatabase * self) {
#line 3 "/home/alain/Vala/planner/src/Services/Database.vala"
	self->priv = PLANNER_SQLITE_DATABASE_GET_PRIVATE (self);
#line 332 "Database.c"
}


static void planner_sqlite_database_finalize (GObject * obj) {
	PlannerSqliteDatabase * self;
#line 3 "/home/alain/Vala/planner/src/Services/Database.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, PLANNER_TYPE_SQLITE_DATABASE, PlannerSqliteDatabase);
#line 5 "/home/alain/Vala/planner/src/Services/Database.vala"
	_sqlite3_close0 (self->priv->db);
#line 6 "/home/alain/Vala/planner/src/Services/Database.vala"
	_g_free0 (self->priv->db_path);
#line 3 "/home/alain/Vala/planner/src/Services/Database.vala"
	G_OBJECT_CLASS (planner_sqlite_database_parent_class)->finalize (obj);
#line 346 "Database.c"
}


GType planner_sqlite_database_get_type (void) {
	static volatile gsize planner_sqlite_database_type_id__volatile = 0;
	if (g_once_init_enter (&planner_sqlite_database_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (PlannerSqliteDatabaseClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) planner_sqlite_database_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (PlannerSqliteDatabase), 0, (GInstanceInitFunc) planner_sqlite_database_instance_init, NULL };
		GType planner_sqlite_database_type_id;
		planner_sqlite_database_type_id = g_type_register_static (G_TYPE_OBJECT, "PlannerSqliteDatabase", &g_define_type_info, 0);
		g_once_init_leave (&planner_sqlite_database_type_id__volatile, planner_sqlite_database_type_id);
	}
	return planner_sqlite_database_type_id__volatile;
}



