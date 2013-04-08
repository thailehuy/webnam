class CartsController < ApplicationController
  before_filter :find_site

  layout 'application'

  def add_to_cart
    product = Refinery::Sites::Product.find(params[:product_id])
    session[:cart_items] ||= []
    session[:cart_items] << product.id
    session["cart_item_product_#{product.id}".to_sym] ||= 0
    session["cart_item_product_#{product.id}".to_sym] += params[:quantity].to_i if params[:quantity].to_i > 0
    render nothing: true
  end

  def remove_from_cart
    product = Refinery::Sites::Product.find(params[:product_id])
    session[:cart_items] ||= []
    session[:cart_items] -= [product.id]
    session["cart_item_product_#{product.id}".to_sym] = nil
    render nothing: true
  end

  def prepare_show
    @slug = @site.slug
    @site_id = @site.id.to_s
    @menu_items = Refinery::Sites::Site::SITE_PAGES
    @menu_items -= ["services"] unless @site.has_services
    @menu_items -= ["products"] unless @site.has_products
    @menu_items -= ["mediagallery"] unless @site.has_gallery
    @menu_items -= ["coupons"] unless @site.has_coupons
    @menu_items -= ["blog"] unless @site.has_blog
    @menu_items -= ["events"] unless @site.has_events

    @menu_padding = (8 - @menu_items.count)*3 - 3
  end

  def view_cart
    @order = @site.orders.new
    session[:cart_items] ||= []
    session[:cart_items].each do |product_id|
      @order.line_items.build(product_id: product_id, quantity: session["cart_item_product_#{product_id}".to_sym])
    end
    @requested_page = "orders/view_cart"
    @selected_menu = "products"

    if prepare_show
      present(@site)
      render "refinery/sites/sites/show"
    end
  end

  def create
    @order = @site.orders.new(params[:order])
    session[:cart_items].each do |product_id|
      @order.line_items.build(product_id: product_id, quantity: params["cart_item_product_#{product_id}".to_sym])
    end


    if @order.save
      session[:cart_items].each do |product_id|
        session["cart_item_product_#{product_id}".to_sym] = nil
      end

      session[:cart_items] = nil
      flash[:notice] = t('order_created')
      redirect_to "/sites/#{@site.slug}/products"
    else
      flash[:error] = t('error_order_created')
      @requested_page = "orders/view_cart"
      @selected_menu = "products"

      if prepare_show
        present(@site)
        render "refinery/sites/sites/show"
      end
    end
  end

  private
  def find_site
    @site = Refinery::Sites::Site.find(session[:current_site])
  end
end