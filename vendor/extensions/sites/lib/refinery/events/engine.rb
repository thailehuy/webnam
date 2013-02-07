module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_events plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "events"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_events_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/event',
            :title => 'event_title'
          }
          plugin.menu_match = %r{refinery/sites/events(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Events)
      end
    end
  end
end
