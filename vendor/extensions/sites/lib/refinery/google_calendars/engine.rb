module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_google_calendars plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "google_calendars"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_google_calendars_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/google_calendar',
            :title => 'account'
          }
          plugin.menu_match = %r{refinery/sites/google_calendars(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::GoogleCalendars)
      end
    end
  end
end
