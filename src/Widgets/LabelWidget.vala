namespace Planner {
    public class LabelWidget : Gtk.Grid {
        private Gtk.Label value_label;
        private Gtk.Label primary_label;
        private Gtk.Label seconday_label;

        private string primary_string;
        private string secondary_string;
        private string value_string;

        public LabelWidget (string _value="0", string primary = "", string secondary = "") {
            halign = Gtk.Align.CENTER;
            valign = Gtk.Align.CENTER;
            //column_homogeneous = true;

            primary_string = primary;
            secondary_string = secondary;
            value_string = _value;

            build_ui ();
        }

        private void build_ui () {
            value_label = new Gtk.Label (value_string);
            value_label.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

            primary_label = new Gtk.Label (primary_string);
            primary_label.margin_left = 12;
            primary_label.halign = Gtk.Align.START;
            primary_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

            seconday_label = new Gtk.Label (secondary_string);
            seconday_label.margin_left = 12;
            seconday_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            seconday_label.halign = Gtk.Align.START;

            attach (value_label, 0, 0, 1, 2);
            attach (primary_label, 1, 0, 1, 1);
            attach (seconday_label, 1, 1, 1, 1);
        }

        public void update_value (string value) {
            value_label.label = value;
        }
    }
}
