module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_aboutus_pages plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "aboutus_pages"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_aboutus_pages_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/aboutus_page',
            :title => 'category'
          }
          plugin.menu_match = %r{refinery/sites/aboutus_pages(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::AboutusPages)
      end
    end
  end
end
