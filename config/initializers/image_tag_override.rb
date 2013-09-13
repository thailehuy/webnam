module ActionView
  module Helpers
    module AssetTagHelper
      def image_tag(source, options={})
        options = options.symbolize_keys

        src = options[:src] = path_to_image(source)

        unless src =~ /^(?:cid|data):/ || src.blank?
          options[:alt] = options.fetch(:alt){ image_alt(src) }
        end

        if @site
          options[:alt] = @site.seo_image_tags.to_s.split(",").map(&:strip).sample
        end

        if size = options.delete(:size)
          options[:width], options[:height] = size.split("x") if size =~ %r{\A\d+x\d+\z}
          options[:width] = options[:height] = size if size =~ %r{\A\d+\z}
        end

        tag("img", options)
      end
    end
  end
end
