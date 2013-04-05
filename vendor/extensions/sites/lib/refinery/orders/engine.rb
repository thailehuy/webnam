module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_orders plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "orders"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_orders_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :orders
          }
          plugin.menu_match = %r{refinery/sites/orders(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Orders)
      end
    end
  end
end
