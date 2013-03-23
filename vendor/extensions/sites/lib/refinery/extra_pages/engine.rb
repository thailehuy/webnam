module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_extra_pages plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "extra_pages"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_extra_pages_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/extra_page'
          }
          plugin.menu_match = %r{refinery/sites/extra_pages(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::ExtraPages)
      end
    end
  end
end
