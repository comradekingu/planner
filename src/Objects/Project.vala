/*
* Copyright (c) 2018 Alain M. (https://github.com/alainm23/planner)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alain M. <alain23@protonmail.com>
*/

namespace Planner {
    public class Objects.Project {
        public int id;
        public string name;
        public string description;
        public string start_date;
        public string final_date;
        public string last_update;
        public string note;
        public string avatar;

        public Project (int id = 1,
            string name = "", string description = "",
            string start_date = "", string final_date = "", string last_update = "",
            string note = "", string avatar = "") {

            this.id = id;
            this.name = name;
            this.description = description;
            this.start_date = start_date;
            this.final_date = final_date;
            this.last_update = last_update;
            this.note = note;
            this.avatar = avatar;
        }
    }
}
