namespace Planner {
    public class Widgets.AllTaskList : Gtk.Grid {
        private Gtk.Entry task_entry;
        private Gtk.Grid task_list_all;

        private Services.Database db;
        private Services.Settings settings;

        public AllTaskList () {
            orientation = Gtk.Orientation.VERTICAL;
            row_spacing = 12;
            expand = true;

            db = new Services.Database (true);
            settings = new Services.Settings ();

            build_ui ();
        }

        private void build_ui () {
            task_entry = new Gtk.Entry ();
            task_entry.hexpand = true;
            task_entry.primary_icon_name = "pager-checked-symbolic";
            task_entry.margin_left = 6;
            task_entry.secondary_icon_activatable = true;
            task_entry.placeholder_text = _("New Task...");

            task_list_all = new Gtk.Grid ();
            task_list_all.orientation = Gtk.Orientation.VERTICAL;
            task_list_all.valign = Gtk.Align.START;
            task_list_all.row_spacing = 6;

            var scrolled = new Gtk.ScrolledWindow (null, null);
            //scrolled.expand = true;
            scrolled.add (task_list_all);


            task_entry.changed.connect( () => {
                if (task_entry.text != "") {
                    task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "list-add-symbolic");
                } else {
                    task_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "");
                }
            });

            task_entry.activate.connect ( () => {
                add_task ();
            });

            task_entry.icon_press.connect ((pos, event) => {
				if (pos == Gtk.EntryIconPosition.SECONDARY) {
					if (task_entry.secondary_icon_name == "list-add-symbolic") {
                        add_task ();
					}
				}
			});

            add (scrolled);
            add (task_entry);

            create_list ();
        }

        private void create_list () {
            var all_task = new Gee.ArrayList<Objects.Task?> ();
            all_task = db.get_all_tasks (settings.project_selected_id);

            foreach (var task in all_task) {
                var row = new TaskRow (task);
                task_list_all.add (row);
            }

            show_all ();
        }

        private void add_task () {
            Objects.Task task = new Objects.Task ();
            task.name = task_entry.text;
            task.id_project = settings.project_selected_id;

            db.add_task (task);

            task_entry.text = "";
        }
    }
}
