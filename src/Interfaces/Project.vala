namespace Planner {
    public class Interfaces.Project {
        public int id;
        public string name;
        public string description;
        public string start_date;
        public string due_date;
        public string type;
        public string avatar;

        public Project (int id = 1, 
            string name = "", string description = "",
            string start_date = "", string due_date = "",
            string type = "", string avatar = "") {

            this.id = id;
            this.name = name;
            this.description = description;
            this.start_date = start_date;
            this.due_date = due_date;
            this.type = type;
            this.avatar = avatar;
        }
    }
}
