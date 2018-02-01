/* Files.c generated by valac 0.36.10, the Vala compiler
 * generated from Files.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>
#include <gio/gio.h>
#include <glib/gstdio.h>

#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))



void planner_utils_create_dir_with_parents (const gchar* dir);
gboolean planner_utils_exists_database (void);


void planner_utils_create_dir_with_parents (const gchar* dir) {
	gchar* path = NULL;
	const gchar* _tmp0_;
	const gchar* _tmp1_;
	gchar* _tmp2_;
	GFile* tmp = NULL;
	const gchar* _tmp3_;
	GFile* _tmp4_;
	GFile* _tmp5_;
	GFileType _tmp6_;
#line 5 "/home/alain/Vala/planner/src/Utils/Files.vala"
	g_return_if_fail (dir != NULL);
#line 7 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp0_ = g_get_home_dir ();
#line 7 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp1_ = dir;
#line 7 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp2_ = g_strconcat (_tmp0_, _tmp1_, NULL);
#line 7 "/home/alain/Vala/planner/src/Utils/Files.vala"
	path = _tmp2_;
#line 8 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp3_ = path;
#line 8 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp4_ = g_file_new_for_path (_tmp3_);
#line 8 "/home/alain/Vala/planner/src/Utils/Files.vala"
	tmp = _tmp4_;
#line 9 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp5_ = tmp;
#line 9 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp6_ = g_file_query_file_type (_tmp5_, 0, NULL);
#line 9 "/home/alain/Vala/planner/src/Utils/Files.vala"
	if (_tmp6_ != G_FILE_TYPE_DIRECTORY) {
#line 54 "Files.c"
		const gchar* _tmp7_;
#line 10 "/home/alain/Vala/planner/src/Utils/Files.vala"
		_tmp7_ = path;
#line 10 "/home/alain/Vala/planner/src/Utils/Files.vala"
		g_mkdir_with_parents (_tmp7_, 0775);
#line 60 "Files.c"
	}
#line 5 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_g_object_unref0 (tmp);
#line 5 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_g_free0 (path);
#line 66 "Files.c"
}


gboolean planner_utils_exists_database (void) {
	gboolean result = FALSE;
	gchar* path = NULL;
	const gchar* _tmp0_;
	gchar* _tmp1_;
	GFile* file = NULL;
	GFile* _tmp2_;
	gboolean tmp = FALSE;
	gboolean _tmp3_;
#line 16 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp0_ = g_get_home_dir ();
#line 16 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp1_ = g_strconcat (_tmp0_, "/.local/share/planner/planner.db", NULL);
#line 16 "/home/alain/Vala/planner/src/Utils/Files.vala"
	path = _tmp1_;
#line 18 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp2_ = g_file_new_for_path (path);
#line 18 "/home/alain/Vala/planner/src/Utils/Files.vala"
	file = _tmp2_;
#line 20 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_tmp3_ = g_file_query_exists (file, NULL);
#line 20 "/home/alain/Vala/planner/src/Utils/Files.vala"
	tmp = _tmp3_;
#line 22 "/home/alain/Vala/planner/src/Utils/Files.vala"
	result = tmp;
#line 22 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_g_object_unref0 (file);
#line 22 "/home/alain/Vala/planner/src/Utils/Files.vala"
	_g_free0 (path);
#line 22 "/home/alain/Vala/planner/src/Utils/Files.vala"
	return result;
#line 101 "Files.c"
}



