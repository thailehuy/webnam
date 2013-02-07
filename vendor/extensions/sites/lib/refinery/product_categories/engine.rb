module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_product_categories plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "product_categories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_product_categories_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/product_category',
            :title => 'name'
          }
          plugin.menu_match = %r{refinery/sites/product_categories(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::ProductCategories)
      end
    end
  end
end
