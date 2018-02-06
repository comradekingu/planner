namespace Planner { 
    public class ProjectList : Gtk.Grid {
        public ProjectList () {
            var label = new Gtk.Label ("Lista de Projectos");
            attach (label, 0, 0, 1, 1);
        }
    }
}