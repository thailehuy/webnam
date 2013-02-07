module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_coupons plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "coupons"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_coupons_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/coupon'
          }
          plugin.menu_match = %r{refinery/sites/coupons(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Coupons)
      end
    end
  end
end
