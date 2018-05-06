namespace Planner.Utils {
    public void create_dir_with_parents (string dir) {

        string path = Environment.get_home_dir () + dir;
        File tmp = File.new_for_path (path);
        if (tmp.query_file_type (0) != FileType.DIRECTORY) {
            GLib.DirUtils.create_with_parents (path, 0775);
        }
    }

    public Gee.ArrayList<string> project_types () {
        var project_types = new Gee.ArrayList<string> ();

        project_types.add ("planner-startup");
        project_types.add ("planner-team");
        project_types.add ("planner-checklist");
        project_types.add ("planner-calendar");
        project_types.add ("planner-chat");
        project_types.add ("planner-cloud");
        project_types.add ("planner-science");
        project_types.add ("planner-development");
        project_types.add ("planner-hearts");
        project_types.add ("planner-star");
        project_types.add ("planner-power");
        project_types.add ("planner-elementary");
        project_types.add ("planner-computer");
        project_types.add ("planner-code");
        project_types.add ("planner-pen");
        project_types.add ("planner-economy");
        project_types.add ("planner-games");
        project_types.add ("planner-prototype");
        project_types.add ("planner-web");
        project_types.add ("planner-online-shop");

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

    public bool is_avatar_icon (string icon_name) {
        Gee.ArrayList<string> project_types = project_types ();

        foreach (string name in project_types) {
            if (icon_name == name) {
                return true;
            }
        }
        return false;
    }

    public int days_ago (string date) {
        /*
        var date_now = new GLib.DateTime.now_local ();
        var date_to_compare = new GLib.DateTime
        //string date_now = datetime.format ("%F");

        datetime.difference
        */
        return 0;
    }
}
