module ApplicationHelper
  def submit_to_popup(label, options = {})
    form_var = options[:form_id] ? "$('#{options[:form_id]}')" : 'this.form'
    js = <<-js
      var form=#{form_var};
      form.target='_blank';
      var action = form.action;
      #{options[:url] ? "form.action='#{options[:url]}'"  : ""}
      $('#preview').val('#{options[:page] || 'home'}');
      $('input[name^=\"ignore_me_\"]').remove();
      $('.wymeditor').each(function(index, element){
        $(element).html($.wymeditors(index).xhtml())
        });
      form.submit();
      form.target='';
      form.action = action;
      $('#preview').val('');
      return false;
    js
    button_to_function label, js
  end

	def darken_color(hex_color, amount=0.5)
		hex_color = hex_color.gsub('#','')
		rgb = hex_color.scan(/../).map {|color| color.hex}
		rgb[0] = (rgb[0].to_i * amount).round
		rgb[1] = (rgb[1].to_i * amount).round
		rgb[2] = (rgb[2].to_i * amount).round
		"#%02x%02x%02x" % rgb
	end

	def get_size_from_style(style)
		style.split(' ')[0]
	end

	def get_color_from_style(style)
		style.split(' ')[1]
	end

	def get_weight_from_style(style)
		style.split(' ')[2]
  end


  def menu_title(page)
    case page
      when 'aboutus'
        @site.aboutus_page.menu_title.blank? ? t('aboutus') : @site.aboutus_page.menu_title

      when 'services'
        @site.services_page.menu_title.blank? ? t('services') : @site.services_page.menu_title

      when 'products'
        @site.products_title.blank? ? t('products') : @site.products_title
      when 'mediagallery'
        @site.seo_gallery_title.blank? ? t(page) : @site.seo_gallery_title
      else
        t(page)
    end
  end


  def language_display_tag(language)

    check_box_tag "site[languages][]",
                  language,
                  @site.languages.include?(language),
                  :class => 'display'

  end

  def carousel_page_display_tag(page)

    check_box_tag "site[carousel_pages][]",
                  page,
                  @site.carousel_pages.include?(page),
                  :class => 'display'

  end


  def background_repeat(bg_repeat)
    Refinery::Sites::Design::BG_REPEAT[bg_repeat]
  end


  def product_length(picture)
    if picture.nil?
      'product-long'
    else
      'product-short'
    end
  end

end
