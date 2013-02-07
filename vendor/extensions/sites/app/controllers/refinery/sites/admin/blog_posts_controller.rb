module Refinery
  module Sites
    module Admin
      class BlogPostsController < ::Refinery::AdminController

        crudify :'refinery/sites/blog_post', :xhr_paging => true,
                :sortable => false

        def find_all_blog_posts(conditions='')
          if @editing_site
            @blog_posts = BlogPost.where(conditions).where({:site_id => session[:current_site]}).order("created_at desc")
          else
            @blog_posts = BlogPost.where(conditions).order("created_at desc")
          end
        end

        def new
          @blog_post = BlogPost.new
          @blog_post.site_id = session[:current_site]
        end

      end
    end
  end
end
