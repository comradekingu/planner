namespace Planner {

    public class Interfaces.List { 

        public int id;
        public string name;
        public string start_date;
        public string due_date;
        public string icon;
        public int task_all;
        public int tasks_completed;
        public int id_project;

        public List (int id = 0, string name = "", 
            string start_date = "", string due_date = "",
            string icon = "", int task_all = 0, 
            int tasks_completed = 0, int id_project = 0) {
                
            this.id = id;
            this.name = name;
            this.start_date = start_date;
            this.due_date = due_date;
            this.icon = icon;
            this.task_all = task_all;
            this.tasks_completed = tasks_completed;
            this.id_project = id_project;

        }
    } 
}