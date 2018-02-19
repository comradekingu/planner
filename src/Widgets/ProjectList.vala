namespace Planner { 
    public class ProjectList : Gtk.ListBox {

        public MainWindow window { get; construct; }

        public ProjectList () {

            set_margin_top (12);
            set_margin_bottom (12);
            set_selection_mode (Gtk.SelectionMode.SINGLE);

            create_list ();
        }
            
        private void create_list () {

            var item1 = new ProjectItem ();
            /* 
            this.row_selected.connect ((item1) => { 

                var message_dialog = new Granite.MessageDialog.with_image_from_icon_name ("Activado", "Funciono", "dialog-warning", Gtk.ButtonsType.CANCEL);
                            
                message_dialog.transient_for = window;
                message_dialog.show_all ();
                message_dialog.run ();
                message_dialog.destroy ();

            });
            */

            this.add (item1);

            var item2 = new ProjectItem ();
            this.add (item2);

            var item3 = new ProjectItem ();
            this.add (item3);

            var item4 = new ProjectItem ();
            this.add (item4);

            /*
            var item5 = new ProjectItem ();
            this.add (item5);

            var item6 = new ProjectItem ();
            this.add (item6);

            var item7 = new ProjectItem ();
            this.add (item7);

            var item8 = new ProjectItem ();
            this.add (item8);

            var item9 = new ProjectItem ();
            this.add (item9);
            
            var item10 = new ProjectItem ();
            this.add (item10);

            var item11 = new ProjectItem ();
            this.add (item11);

            var item12 = new ProjectItem ();
            this.add (item12);

            var item13 = new ProjectItem ();
            this.add (item13);
             */
        }
    }
}