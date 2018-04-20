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

        name_icon_list.add ("emblem-favorite-symbolic");
        name_icon_list.add ("emblem-documents-symbolic");
        name_icon_list.add ("computer-symbolic");
        name_icon_list.add ("application-xml-symbolic");
        name_icon_list.add ("emblem-music-symbolic");
        name_icon_list.add ("preferences-system-symbolic");
        name_icon_list.add ("emblem-default-symbolic");
        name_icon_list.add ("edit-symbolic");
        name_icon_list.add ("edit-find-symbolic");
        name_icon_list.add ("help-contents-symbolic");
        name_icon_list.add ("insert-link-symbolic");
        name_icon_list.add ("help-info-symbolic");
        name_icon_list.add ("appointment-symbolic");
        name_icon_list.add ("go-home-symbolic");
        name_icon_list.add ("find-location-symbolic");
        name_icon_list.add ("browser-download-symbolic");
        name_icon_list.add ("x-office-calendar-symbolic");
        name_icon_list.add ("x-office-presentation-symbolic");
        name_icon_list.add ("alarm-symbolic");
        name_icon_list.add ("printer-symbolic");
        name_icon_list.add ("phone-symbolic");
        name_icon_list.add ("system-software-install-symbolic");
        name_icon_list.add ("system-run-symbolic");
        name_icon_list.add ("applications-games-symbolic");
        name_icon_list.add ("applications-science-symbolic");
        name_icon_list.add ("view-paged-symbolic");
        name_icon_list.add ("send-to-symbolic");
        name_icon_list.add ("bug-symbolic");
        name_icon_list.add ("view-list-images-symbolic");
        name_icon_list.add ("internet-mail-symbolic");
        name_icon_list.add ("applications-development-symbolic");
        name_icon_list.add ("emblem-videos-symbolic");
        name_icon_list.add ("folder-templates-symbolic");
        name_icon_list.add ("preferences-desktop-online-accounts-symbolic");
        name_icon_list.add ("edit-flag-symbolic");
        name_icon_list.add ("help-about-symbolic");
        name_icon_list.add ("event-birthday-symbolic");
        name_icon_list.add ("applications-multimedia-symbolic");
        name_icon_list.add ("preferences-color-symbolic");

        return name_icon_list;
    }
}
