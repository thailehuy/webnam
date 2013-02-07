module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_home_pages plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "home_pages"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_home_pages_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/home_page'
          }
          plugin.menu_match = %r{refinery/sites/home_pages(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::HomePages)
      end
    end
  end
end
