class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_site_mode, :set_best_locale

  def set_site_mode
	  @editing_site = session[:current_site].present? && (session[:current_site] != -1)
#    @site_name = @editing_site ? Site.find(session[:current_site]).name : 'No site'
  end

  def home
    @sites = Site.order('position ASC')
  end

  def set_best_locale

#    logger.info "\nStarting method : set_best_locale with globalize_locale = " +  Thread.current[:globalize_locale].to_s

    if cookies[:chosen_locale].nil?
      Thread.current[:globalize_locale] = best_choice_from_browser
#      logger.info "Choice from browser ... " +  Thread.current[:globalize_locale].to_s + "\n"
    else
      Thread.current[:globalize_locale] = cookies[:chosen_locale]
#      logger.info "Choice from cookie ... " +  Thread.current[:globalize_locale].to_s + "\n"
    end

    if locale = params[:new_locale]
      locale = locale.try(:to_sym)
      if ::Refinery::I18n.frontend_locales.include?(locale)
        cookies[:chosen_locale] = {:value => locale, :expires => 1.year.from_now}
#        logger.info "Language registered: " + locale.to_s + "\n"
        Thread.current[:globalize_locale] = locale
      else
#        logger.info "Language rejected: " + locale.to_s + "\n"
      end
    end
    ::I18n.locale = Thread.current[:globalize_locale]

  end

  def best_choice_from_browser
    ((http_accept_language.compatible_language_from ::Refinery::I18n.frontend_locales) || 'en').try(:to_sym)
  end

end
