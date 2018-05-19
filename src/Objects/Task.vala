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
    public class Objects.Task {
        public int id;
        public string name;
        public string note;
        public string state;
        public string deadline;
        public int id_project;
        public int id_milestone;

        public Task (int id = 1,
            string name = "", string note = "",
            string state = "false", string deadline = "", int id_project = 1,
            int id_milestone = 1) {

            this.id = id;
            this.name = name;
            this.note = note;
            this.state = state;
            this.deadline = deadline;
            this.id_project = id_project;
            this.id_milestone = id_milestone;
        }
    }
}
