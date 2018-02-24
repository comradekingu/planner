namespace Planner { 
    public class Project { 
        public string id;
        public string name;
        public string description;
        public string start_date;
        public string final_date;
        public string logo;

        public Project (string id = "", 
            string name = "", string description = "",
            string start_date = "", string final_date = "",
            string logo = "") {
                
            this.id = id;
            this.name = name;
            this.description = description;
            this.start_date = start_date;
            this.final_date = final_date;
            this.logo = logo;
        }
    } 
}
