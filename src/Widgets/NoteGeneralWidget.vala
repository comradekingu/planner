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

            note_view = new Gtk.TextView ();
            note_view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
            note_view.expand = true;
            note_view.buffer.text = project_actual.note;

            var tag_bold = note_view.buffer.create_tag ("bold");
            var tag_italic = note_view.buffer.create_tag ("italic");
            var tag_underline = note_view.buffer.create_tag ("underline");

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.expand = true;
            scrolled.add (note_view);

            var format_button = new Gtk.Button.from_icon_name ("format-text-larger-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            format_button.halign = Gtk.Align.START;
            format_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            format_popover = new TextFormatPopover (format_button);
            format_button.clicked.connect ( () => {
                format_popover.show_all ();
            });

            add (title_label);
            add (scrolled);
            //add (format_button);
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
