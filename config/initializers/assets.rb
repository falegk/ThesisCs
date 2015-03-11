# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# thesis2

Rails.application.config.assets.precompile += %w( thesis2/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( thesis2/bootstrap-responsive.min.css )
Rails.application.config.assets.precompile += %w( thesis2/font-awesome.css )
Rails.application.config.assets.precompile += %w( thesis2/style.css )
Rails.application.config.assets.precompile += %w( welcome.css )
Rails.application.config.assets.precompile += %w( chosen.css )
Rails.application.config.assets.precompile += %w( plugins/chosen/prism.css )
# Static Pages
Rails.application.config.assets.precompile += %w( static-pages/bootstrap.css )
Rails.application.config.assets.precompile += %w( static-pages/theme-style.css )
Rails.application.config.assets.precompile += %w( plugins/faq.css )

=begin
Rails.application.config.assets.precompile += %w( chosen/style.css )
=end

Rails.application.config.assets.precompile += %w( thesis2/jquery-1.7.2.min.js )
Rails.application.config.assets.precompile += %w( thesis2/excanvas.min.js )
Rails.application.config.assets.precompile += %w( thesis2/bootstrap.js )
Rails.application.config.assets.precompile += %w( thesis2/base.js )
Rails.application.config.assets.precompile += %w( jquery_ujs.js )
Rails.application.config.assets.precompile += %w( chosen.jquery.js )
Rails.application.config.assets.precompile += %w( plugins/chosen/prism.js )
Rails.application.config.assets.precompile += %w( plugins/chosen/chosen-configs.js )
# Static Pages
Rails.application.config.assets.precompile += %w( static-pages/jquery.min.js )
Rails.application.config.assets.precompile += %w( static-pages/responsiveslides.min.js )
Rails.application.config.assets.precompile += %w( static-pages/easyResponsiveTabs.js )
Rails.application.config.assets.precompile += %w( plugins/faq.js )




# thesisCs old theme
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( plugins/metisMenu/metisMenu.min.css )
Rails.application.config.assets.precompile += %w( sb-admin-2.css )
Rails.application.config.assets.precompile += %w( font-awesome-4.1.0/css/font-awesome.min.css )
#Rails.application.config.assets.precompile += %w( bootstrap.css )

Rails.application.config.assets.precompile += %w( jquery-1.11.0.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( plugins/metisMenu/metisMenu.min.js )
Rails.application.config.assets.precompile += %w( sb-admin-2.js )


Rails.application.config.assets.precompile += %w( ckeditor/* )