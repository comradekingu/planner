namespace Planner {
	public class ProjectStartupView : Gtk.EventBox {
		private Gtk.Label title_label;
    	private Gtk.Label subtitle_label;
        private Gtk.Image image;

    	private Gtk.Button image_button;
    	private Gtk.Entry name_entry;
    	private Gtk.Entry description_entry;

        private Gtk.Button create_button;

		private LogoPopover logo_popover;


        public signal void on_cancel_button ();
        public signal void on_create_button (Project new_project);

        // Interface
        private Project new_project;

		public ProjectStartupView () {

			get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
			get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);

			build_ui ();
		}

		private void build_ui () {

			title_label = new Gtk.Label (_("First project"));
	        title_label.justify = Gtk.Justification.CENTER;
	        title_label.hexpand = true;
	        title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

	        subtitle_label = new Gtk.Label ("Please choose a new avatar, name and description");
	        subtitle_label.justify = Gtk.Justification.CENTER;
	        subtitle_label.hexpand = true;
	        subtitle_label.wrap = true;
	        subtitle_label.wrap_mode = Pango.WrapMode.WORD;
	        subtitle_label.get_style_context().add_class (Gtk.STYLE_CLASS_DIM_LABEL);
        	subtitle_label.get_style_context().add_class (Granite.STYLE_CLASS_H2_LABEL);

        	// Project Avatar
        	var avatar_label = new Granite.HeaderLabel (_("Project Avatar"));
        	avatar_label.margin_top = 24;

        	image_button = new Gtk.Button ();
        	image_button.halign = Gtk.Align.CENTER;
        	image_button.margin_top = 24;
        	image_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

        	image = new Gtk.Image.from_icon_name("planner-startup", Gtk.IconSize.DND);
            image.pixel_size = 64;
        	
        	image_button.image = image;
        	
        	//logoPopover
        	logo_popover = new LogoPopover (image_button);

        	// Project Name

        	var name_entry_label = new Granite.HeaderLabel (_("Project Name"));
        	name_entry_label.margin_top = 24;

        	name_entry = new Gtk.Entry ();
            name_entry.width_request = 100;
        	name_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
        	name_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_TITLE);
            name_entry.changed.connect ( () => {
                if (name_entry.text != "") {
                    create_button.sensitive = true;
                } else {
                    create_button.sensitive = false;
                }
            });
        	
        	// Description Widget
        	var description_view_label = new Granite.HeaderLabel (_("Project Description"));
        	description_view_label.margin_top = 24;

        	description_entry = new Gtk.Entry ();
            description_entry.width_request = 100;
        	description_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
        	description_entry.get_style_context ().add_class (Gtk.STYLE_CLASS_TITLE);
        	
        	image_button.clicked.connect ( () => {

        		logo_popover.show_all ();
                
        	});
        	
        	logo_popover.on_image_select.connect ( (icon_name) => {

        		image.icon_name = icon_name;
        		image_button.image = image;
                image_button.can_focus = false;
        	});

            var cancel_button = new Gtk.Button.with_label (_("Cancel"));
            cancel_button.clicked.connect ( () => {
                
                clear_all ();

                on_cancel_button ();
            });

            create_button = new Gtk.Button.with_label (_("Create Project"));
            create_button.sensitive = false;
            create_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            create_button.clicked.connect (create_button_clicked);


            var action_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            action_box.margin_top = 50;
            action_box.margin_bottom = 40;
            action_box.homogeneous = true;
            action_box.halign = Gtk.Align.END;
            action_box.pack_start (cancel_button, true, true, 0);
            action_box.pack_end (create_button, true, true, 0);


        	var content = new Gtk.Grid ();
	        content.expand = true;
	        content.margin_top = 12;
	        content.valign = Gtk.Align.CENTER;
	        content.halign = Gtk.Align.CENTER;
	        content.orientation = Gtk.Orientation.VERTICAL;
	        
	        content.add (title_label);
	        content.add (subtitle_label);
	        //content.add (avatar_label);
	        content.add (image_button);
	        content.add (name_entry_label);
	        content.add (name_entry);
	        content.add (description_view_label);
	        content.add (description_entry);
            content.add (action_box);

	        add (content);
		}

        public void clear_all () {

            name_entry.text = "";
            description_entry.text = "";
            
        }	

        private void create_button_clicked () {

            new_project = new Project ();

            new_project.name = name_entry.text;
            new_project.description = description_entry.text;
            new_project.logo = image.icon_name;

            on_create_button (new_project);
        }
	}
}