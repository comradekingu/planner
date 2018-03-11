<div align="center">
    <p align="center">
        <img src="https://cdn.rawgit.com/alainm23/planner/master/data/icons/128/com.github.alainm23.planner.svg" alt="Icon" />
    </p>
    <h1 align="center">Planner</h1>
    <h3 align="center">
        Project manager designed for elementary OS
    </h3>
    <h4 align="center" style="color:red;">
        App under development!    
    </h4>
</div>

<br />

## Installation

### Dependencies
These dependencies must be present before building

 - `meson`
 - `valac`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libglib2.0-dev`
 - `libsqlite3-dev`

### Building

```
git clone https://github.com/alainm23/planner.git
meson build && cd build
meson configure -Dprefix=/usr
ninja
sudo ninja install
com.github.alainm23.planner
```

### Deconstruct

```
sudo ninja uninstall
```
