module Refinery
  module Sites
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sites

      engine_name :refinery_sites

      initializer "register refinerycms_blog_posts plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "blog_posts"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sites_admin_blog_posts_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sites/blog_post'
          }
          plugin.menu_match = %r{refinery/sites/blog_posts(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::BlogPosts)
      end
    end
  end
end
