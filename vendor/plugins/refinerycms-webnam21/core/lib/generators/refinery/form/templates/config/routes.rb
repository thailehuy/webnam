Refinery::Core::Engine.routes.append do
  # Frontend routes
  namespace :<%= namespacing.underscore %> do
    resources :<%= plural_name %><%= ", :path => ''" if namespacing.underscore == plural_name %>, :only => [:new, :create] do
      collection do
        get :thank_you
      end
    end
  end

  # Admin routes
  namespace :<%= namespacing.underscore %>, :path => '' do
    namespace :admin, :path => 'refinery/<%= namespacing.underscore %>' do
      resources :<%= plural_name %>, :path => '' <% if @includes_spam %> do
        collection do
          get :spam
        end
        member do
          get :toggle_spam
        end
      end<% end %>
      resources :settings
    end
  end
end

