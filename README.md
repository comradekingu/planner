# We moved
## I have decided to create an organization to maintain Planner, from now on that will be the official repository and any update and the future release will be made from there, see you ...
<p align="center">
  <img src="https://cdn.rawgit.com/alainm23/planner/master/data/icons/128/com.github.alainm23.planner.svg" alt="Icon" />
</p>
<h1 align="center">Planner</h1>
<h3 align="center">Project manager designed for elementary OS</h3>
<p align="center">
  <a href="https://appcenter.elementary.io/com.github.alainm23.planner"><img src="https://appcenter.elementary.io/badge.svg?new" alt="Get it on AppCenter" /></a>
</p>

![Screenshot](data/screenshot/screenshot-1.png?raw=true)
![Screenshot](data/screenshot/screenshot-2.png?raw=true)
![Screenshot](data/screenshot/screenshot-3.png?raw=true)

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
meson build && cd build
meson configure -Dprefix=/usr
sudo ninja install
```

### Deconstruct

```
sudo ninja uninstall
```
