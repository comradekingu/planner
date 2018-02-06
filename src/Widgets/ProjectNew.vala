namespace Planner {
    public class ProjectNew : Gtk.Grid {
        public ProjectNew () {
            var label = new Gtk.Label ("Nuevo PRojecto");
            
            attach (label, 0, 0, 1, 1);
        }
    }  
}