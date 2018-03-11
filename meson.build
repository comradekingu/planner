project('com.github.alainm23.planner', 'vala', 'c',
    version: '0.0.1')

gnome = import('gnome')
i18n = import('i18n')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h'
]

add_global_arguments('-DGETTEXT_PACKAGE="' + meson.project_name() + '"', language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

executable(
    meson.project_name(),
    asresources,
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Widgets/Headerbar.vala',
    'src/Views/WelcomeView.vala',
    'src/Views/ProjectStartupView.vala',
    'src/Views/OverviewView.vala',
    'src/Views/TaskView.vala',
    'src/Views/IssuesView.vala',
    'src/Widgets/ProjectButton.vala',
    'src/Widgets/Popover/ProjectPopover.vala',
    'src/Widgets/Popover/ProjectList.vala',
    'src/Widgets/Popover/ProjectNewUpdate.vala',
    'src/Widgets/Popover/ProjectItem.vala',
    'src/Widgets/Popover/AvatarPopover.vala',
    'src/Widgets/FormatBar.vala',
    'src/Utils/Utils.vala',
    'src/Interfaces/Project.vala',
    'src/Services/Database.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('sqlite3'),
        meson.get_compiler('c').find_library('m', required : false)
    ],
    install: true
)
subdir('data')

meson.add_install_script('meson/post_install.py')
