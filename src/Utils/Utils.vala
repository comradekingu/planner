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

    public Gee.ArrayList<string> name_months () {

        var name_months = new Gee.ArrayList<string> ();

        name_months.add (_("January"));
        name_months.add (_("February"));
        name_months.add (_("March"));
        name_months.add (_("April"));
        name_months.add (_("May"));
        name_months.add (_("June"));
        name_months.add (_("July"));
        name_months.add (_("August"));
        name_months.add (_("September"));
        name_months.add (_("October"));
        name_months.add (_("November"));
        name_months.add (_("December"));

        return name_months;

    }


    public Gee.ArrayList<string> name_icon_list () {

        var name_icon_list = new Gee.ArrayList<string> ();

        name_icon_list.add ("appointment-symbolic");
        name_icon_list.add ("document-open-symbolic");
        name_icon_list.add ("edit-find-symbolic");
        name_icon_list.add ("edit-symbolic");
        name_icon_list.add ("help-info-symbolic");
        name_icon_list.add ("help-contents-symbolic");
        name_icon_list.add ("camera-photo-symbolic");
        name_icon_list.add ("web-browser-symbolic");
        name_icon_list.add ("system-users-symbolic");
        name_icon_list.add ("office-calendar-symbolic");
        name_icon_list.add ("event-birthday-symbolic");
        name_icon_list.add ("applications-games-symbolic");
        name_icon_list.add ("phone-symbolic");
        name_icon_list.add ("tablet-symbolic");
        name_icon_list.add ("tv-symbolic");
        name_icon_list.add ("emblem-favorite-symbolic");
        name_icon_list.add ("emblem-important-symbolic");
        name_icon_list.add ("emblem-default-symbolic");
        name_icon_list.add ("emblem-shared-symbolic");
        name_icon_list.add ("emblem-documents-symbolic");
        name_icon_list.add ("emblem-ok-symbolic");
        name_icon_list.add ("emblem-photos-symbolic");
        name_icon_list.add ("media-audio-symbolic");
        name_icon_list.add ("application-rss+xml-symbolic");
        name_icon_list.add ("x-office-address-book-symbolic");
        name_icon_list.add ("folder-templates-symbolic");
        name_icon_list.add ("user-bookmarks-symbolic");
        name_icon_list.add ("user-home-symbolic");
        name_icon_list.add ("folder-saved-search-symbolic");
        name_icon_list.add ("alarm-symbolic");
        name_icon_list.add ("isert-link-symbolic");
        name_icon_list.add ("view-paged-symbolic");
        name_icon_list.add ("internet-mail-symbolic");
        name_icon_list.add ("system-software-install-symbolic");
        name_icon_list.add ("utilities-terminal-symbolic");
        name_icon_list.add ("preferences-color-symbolic");
        name_icon_list.add ("applications-graphics-symbolic");                
        name_icon_list.add ("bug-symbolic");        
        name_icon_list.add ("applications-science-symbolic");
        name_icon_list.add ("preferences-desktop-online-accounts-symbolic");
        name_icon_list.add ("audio-headphones-symbolic");
        name_icon_list.add ("printer-symbolic");
        name_icon_list.add ("audio-input-microphone-symbolic");
        name_icon_list.add ("html-symbolic");
        name_icon_list.add ("credit-card-symbolic");
        name_icon_list.add ("text-x-copying-symbolic");
        name_icon_list.add ("x-office-presentation-symbolic");
        name_icon_list.add ("x-office-address-book-symbolic");
        name_icon_list.add ("x-office-calendar-symbolic");
        name_icon_list.add ("x-office-document-symbolic");
        name_icon_list.add ("x-office-drawing-symbolic");
        name_icon_list.add ("distributor-logo-symbolic");
        name_icon_list.add ("checkbox-cheked-symbolic");
        name_icon_list.add ("display-brightness-cymbolic");
        
        return name_icon_list;

    }
}