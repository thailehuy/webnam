module ActionView
  module Helpers
    module AssetTagHelper
      def image_tag(source, options = {})
        if @site
          options[:alt] = @site.seo_image_tags.to_s.split(",").map(&:strip).sample
        end
        options[:src] = source
        tag("img", options)
      end
    end
  end
end
