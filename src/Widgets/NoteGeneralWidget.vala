namespace Planner {
    public class NoteGeneralWidget : Gtk.Grid {
        private Gtk.Label title_label;
        private Gtk.TextView note_view;
        private TextFormatPopover format_popover;

        private Services.Database db;
        private GLib.Settings settings;

        Interfaces.Project project_actual;

        public NoteGeneralWidget () {
            orientation = Gtk.Orientation.VERTICAL;
            expand = true;
            row_spacing = 12;
            margin_bottom = 24;
            margin_left = 48;

            db = new Services.Database (true);
            settings = new GLib.Settings ("com.github.alainm23.planner");

            project_actual = new Interfaces.Project ();

            build_ui ();
        }

        private void build_ui () {
            title_label = new Gtk.Label (_("<b>Notes</b>"));
            title_label.use_markup = true;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.halign = Gtk.Align.START;

            var l = new Gtk.Label ("");

            note_view = new Gtk.TextView ();
            note_view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
            note_view.expand = true;
            note_view.buffer.text = project_actual.note;
            note_view.enter_notify_event.connect ( (event) => {
                l.label = "Cursor se movio";
                return false;
            });

            var tag_bold = note_view.buffer.create_tag ("bold");
            var tag_italic = note_view.buffer.create_tag ("italic");
            var tag_underline = note_view.buffer.create_tag ("underline");

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.expand = true;
            scrolled.add (note_view);

            format_popover = new TextFormatPopover (null);


             /*
            var n = new Gtk.Button.with_label ("Negrita");

            n.clicked.connect ( () => {
                Gtk.TextIter start;
                Gtk.TextIter end;

                note_view.buffer.get_selection_bounds (out start, out end);
                note_view.buffer.apply_tag_by_name ("bold", start, end);
                l.label = note_view.buffer.get_text (start, end, true);

            });
            */

            add (title_label);
            add (scrolled);
            add (l);
        }

        public void update_widget () {
            project_actual = db.get_project (settings.get_int ("last-project-id"));
            note_view.buffer.text = project_actual.note;
            note_view.buffer.changed.connect ( () => {
                project_actual.note = note_view.buffer.text;

                Thread<void*> thread = new Thread<void*>.try("Update_Project_Note", () => {
                    db.update_project (project_actual);
                    return null;
                });
            });
        }
    }
}
