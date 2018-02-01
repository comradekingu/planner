namespace Planner {
    public class AppSettings : Granite.Services.Settings {
        
        private static AppSettings? instance;

        public int window_height { get; set; }
        public int window_width { get; set; }

        public static unowned AppSettings get_default () {
            if (instance == null) {
                instance = new AppSettings ();
            }
            return instance;
        }

        private AppSettings () {
            base ("com.github.alainm23.planner");
        }
    }
}