module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_designs plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "designs"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_designs_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/design',
            :title => 'scss_model'
          }
          plugin.menu_match = %r{refinery/sites/designs(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Designs)
      end
    end
  end
end
