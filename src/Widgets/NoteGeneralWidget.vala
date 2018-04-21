namespace Planner {
    public class NoteGeneralWidget : Gtk.Grid {
        private Gtk.Label title_label;
        private Gtk.TextView note_view;

        public NoteGeneralWidget () {
            orientation = Gtk.Orientation.VERTICAL;
            expand = true;
            row_spacing = 12;
            margin_bottom = 24;

            build_ui ();
        }

        private void build_ui () {
            title_label = new Gtk.Label ("<b>Notes</b>");
            title_label.use_markup = true;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            title_label.halign = Gtk.Align.START;

            note_view = new Gtk.TextView ();
            note_view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);
            note_view.expand = true;

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.expand = true;
            scrolled.add (note_view);

            add (title_label);
            add (scrolled);
        }
    }
}
