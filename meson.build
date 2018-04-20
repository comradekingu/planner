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

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

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
    'src/Widgets/Popover/AvatarPopover.vala',
    'src/Widgets/Popover/NewEditListPopover.vala',
    'src/Widgets/ProjectList.vala',
    'src/Widgets/ProjectNewUpdate.vala',
    'src/Widgets/ProjectItem.vala',
    'src/Widgets/MilestoneList.vala',
    'src/Widgets/TaskList.vala',
    'src/Widgets/FormatBar.vala',
    'src/Widgets/ListMilestoneRow.vala',
    'src/Widgets/TaskListRow.vala',
    'src/Widgets/ProgressWidget.vala',
    'src/Widgets/LabelWidget.vala',
    'src/Utils/Utils.vala',
    'src/Interfaces/Project.vala',
    'src/Interfaces/List.vala',
    'src/Interfaces/Task.vala',
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
subdir('po')

meson.add_install_script('meson/post_install.py')
