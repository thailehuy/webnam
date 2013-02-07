Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :sites do
    resources :sites, :path => '', :only => [:index, :show]
  end
  match "/sites/:id/coupon_create/:coupon" => 'sites/sites#coupon_create', :as => :coupon_create
  match "/sites/:id/message" => 'sites/sites#message', :as => :message_post
  match "/sites/:id/search" => 'sites/sites#search', :as => :search_site

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :sites, :except => :show do
        collection do
          post :update_positions
        end
        get 'close', :on => :member
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :home_pages, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :home_pages, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :aboutus_pages, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :aboutus_pages, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

	match "/sites/:id/:page" => 'sites/sites#show'


  # Frontend routes
  namespace :sites do
    resources :designs, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :designs, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :services_pages, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :services_pages, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :coupons_pages, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :coupons_pages, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :coupons, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :coupons, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :blog_posts, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :blog_posts, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :events, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :product_categories, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :product_categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :products, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :products, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :sites do
    resources :google_calendars, :only => [:index, :show]
  end

  # Admin routes
  namespace :sites, :path => '' do
    namespace :admin, :path => 'refinery/sites' do
      resources :google_calendars, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
