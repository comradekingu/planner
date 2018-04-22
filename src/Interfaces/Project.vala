namespace Planner {
    public class Interfaces.Project {
        public int id;
        public string name;
        public string description;
        public string start_date;
        public string due_date;
        public string last_update;
        public string note;
        public string type;
        public string avatar;

        public Project (int id = 1,
            string name = "", string description = "",
            string start_date = "", string due_date = "", string last_update = "",
            string note = "", string type = "", string avatar = "") {

            this.id = id;
            this.name = name;
            this.description = description;
            this.start_date = start_date;
            this.due_date = due_date;
            this.last_update = last_update;
            this.note = note;
            this.type = type;
            this.avatar = avatar;
        }
    }
}
