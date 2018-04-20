namespace Planner {
    public class Interfaces.Task {
        public int id;
        public string name;
        public string state;
        public string deadline;
        public string note;
        public int id_list;

        public Task (int id=1, string name="",
                        string state="false", string deadline="",
                        string note="", int id_list=1) {

            this.id = id;
            this.name = name;
            this.state = state;
            this.deadline = deadline;
            this.note = note;
            this.id_list = id_list;
        }
    }
}
