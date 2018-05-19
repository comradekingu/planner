project('com.github.alainm23.planner', 'vala', 'c')

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
    'src/Utils/Utils.vala',
    'src/Services/Settings.vala',
    'src/Services/Database.vala',
    'src/Widgets/ProjectsList.vala',
    'src/Widgets/ModelButton.vala',
    'src/Widgets/CropView.vala',
    'src/Widgets/ProjectRow.vala',
    'src/Widgets/TodayNotification.vala',
    'src/Widgets/Headerbar.vala',
    'src/Widgets/ProjectButton.vala',
    'src/Widgets/FormatBar.vala',
    'src/Widgets/FormatButton.vala',
    'src/Widgets/NotificationsGrid.vala',
    'src/Widgets/TasksGrid.vala',
    'src/Widgets/AllTaskList.vala',
    'src/Widgets/Popovers/NewEditProject.vala',
    'src/Widgets/WorkList.vala',
    'src/Widgets/TaskList.vala',
    'src/Widgets/TaskRow.vala',
    'src/Views/TodayView.vala',
    'src/Views/OverviewView.vala',
    'src/Views/IssuesView.vala',
    'src/Views/WorkSpaceView.vala',
    'src/Objects/Project.vala',
    'src/Objects/Task.vala',
    'src/Dialogs/AvatarDialog.vala',
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('libsoup-2.4'),
        dependency('json-glib-1.0'),
        dependency('gtk+-3.0'),
        dependency('sqlite3'),
        meson.get_compiler('c').find_library('m', required : false)
    ],
    install: true
)

subdir('data')
#subdir('po')
meson.add_install_script('meson/post_install.py')
