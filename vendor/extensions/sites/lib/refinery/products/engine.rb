module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_products plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "products"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_products_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/product',
            :title => 'name'
          }
          plugin.menu_match = %r{refinery/sites/products(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Products)
      end
    end
  end
end
