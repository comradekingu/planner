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

    public Gee.ArrayList<string> name_icon_list () {
        var name_icon_list = new Gee.ArrayList<string> ();

        name_icon_list.add ("process-completed");
        name_icon_list.add ("document-open");
        name_icon_list.add ("document-page-setup");
        name_icon_list.add ("help-about");
        name_icon_list.add ("help-contents");
        name_icon_list.add ("dialog-information");
        name_icon_list.add ("avatar-default");
        name_icon_list.add ("dialog-error");
        name_icon_list.add ("dialog-information");
        name_icon_list.add ("dialog-warning");
        name_icon_list.add ("network-server");
        name_icon_list.add ("user-trash");
        name_icon_list.add ("distributor-logo");
        name_icon_list.add ("text-x-sql");
        name_icon_list.add ("vcard");
        name_icon_list.add ("printer");
        name_icon_list.add ("phone");
        name_icon_list.add ("applications-internet");
        name_icon_list.add ("preferences-system-time");
        name_icon_list.add ("applications-development");
        name_icon_list.add ("applications-webbrowsers");
        name_icon_list.add ("preferences-system");
        name_icon_list.add ("multimedia-audio-player");
        name_icon_list.add ("multimedia-video-player");
        name_icon_list.add ("internet-mail");
        name_icon_list.add ("accessories-camera");
        name_icon_list.add ("internet-news-reader");
        name_icon_list.add ("accessories-text-editor");
        name_icon_list.add ("internet-chat");
        name_icon_list.add ("system-users");
        name_icon_list.add ("system-software-install");
        name_icon_list.add ("utilities-terminal");
        name_icon_list.add ("office-address-book");
        name_icon_list.add ("edit-paste");
        name_icon_list.add ("insert-link");
        name_icon_list.add ("mail-archive");
        name_icon_list.add ("document-edit");
        name_icon_list.add ("builder");
        name_icon_list.add ("chrome-hmjkmjkepdijhoojdojkdfohbdgmmhki-Default");
        name_icon_list.add ("Pencil");
        name_icon_list.add ("bug");

        return name_icon_list;
    }
}
