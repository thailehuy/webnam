module Refinery
  module Sites
    class BlogPostsController < ::ApplicationController

      before_filter :find_all_blog_posts
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @blog_post in the line below:
        present(@page)
      end

      def show
        @blog_post = BlogPost.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @blog_post in the line below:
        present(@page)
      end

    protected

      def find_all_blog_posts
        @blog_posts = BlogPost.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/blog_posts").first
      end

    end
  end
end
