namespace Planner {
	public class Views.IssuesView : Gtk.EventBox {
		private Gtk.Entry username_entry;
		private Gtk.Entry password_entry;
		private Gtk.Button save_button;
		private Gtk.LinkButton forgot_button;
		private Gtk.LinkButton signup_button;

		public IssuesView () {
			get_style_context ().add_class ("login");
            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.margin = 12;
            main_grid.halign = Gtk.Align.CENTER;
            main_grid.valign = Gtk.Align.CENTER;
            main_grid.column_spacing = 12;
            main_grid.row_spacing = 6;
            main_grid.orientation = Gtk.Orientation.VERTICAL;

			var github_image = new Gtk.Image.from_icon_name ("planner-github", Gtk.IconSize.DIALOG);

            var title_label = new Gtk.Label (_("Github"));
            title_label.get_style_context ().add_class ("h1");

			var subtitle_label = new Gtk.Label (_("Connect your account to work with issues."));
			subtitle_label.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);
			subtitle_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
			subtitle_label.margin_bottom = 24;

			username_entry = new Gtk.Entry ();
			username_entry.placeholder_text = _("Username");
			username_entry.width_request = 250;
			//username_entry.primary_icon_name = "system-users-symbolic";

			password_entry = new Gtk.Entry ();
			password_entry.width_request = 250;
			//password_entry.primary_icon_name = "dialog-password-symbolic";

			password_entry.placeholder_text = _("Password");
			password_entry.visibility = false;
			password_entry.input_purpose = Gtk.InputPurpose.PASSWORD;

			var entrys_grid = new Gtk.Grid ();
			entrys_grid.orientation = Gtk.Orientation.VERTICAL;
			entrys_grid.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
			entrys_grid.halign = Gtk.Align.CENTER;
			entrys_grid.add (username_entry);
			entrys_grid.add (password_entry);

			save_button = new Gtk.Button.with_label (_("Log In"));
 			save_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
			save_button.margin_top = 12;
			save_button.width_request = 250;
			save_button.halign = Gtk.Align.CENTER;
			save_button.sensitive = false;

			forgot_button = new Gtk.LinkButton.with_label ("https://github.com/password_reset", _("Forgot password…"));
			signup_button = new Gtk.LinkButton.with_label ("https://github.com/join", _("Don't have an account? Sign Up"));

			username_entry.changed.connect ( () => {
				if (username_entry.text != "" && password_entry.text != "") {
					save_button.sensitive = true;
				} else {
					save_button.sensitive = false;
				}
			});

			password_entry.changed.connect ( () => {
				if (username_entry.text != "" && password_entry.text != "") {
					save_button.sensitive = true;
				} else {
					save_button.sensitive = false;
				}
			});

			password_entry.activate.connect ( () => {
				check_token ();
			});

			main_grid.add (github_image);
			main_grid.add (title_label);
			main_grid.add (subtitle_label);
			main_grid.add (entrys_grid);
			main_grid.add (save_button);
			main_grid.add (forgot_button);
			main_grid.add (signup_button);

            add (main_grid);
        }

		private void check_token () {
			// Code to get Token
		}
    }
}
