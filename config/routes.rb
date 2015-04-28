Rails.application.routes.draw do

  get 'pages/index'

  root :to => redirect('http://julianbonilla.github.io/miami-transit-api-docs/')

  get 'buses' => 'miami_dade_transit#buses'
  get 'bus/:id' => 'miami_dade_transit#bus'
  get 'nearby' => 'miami_dade_transit#nearby'

  post 'tracker' => 'miami_dade_transit#tracker_new'
  get 'tracker' => 'tracker#live'

  get 'api/trolley/routes' => 'miami_city_transit#routes'
  get 'api/trolley/stops' => 'miami_city_transit#stops'
  get 'api/trolley/vehicles' => 'miami_city_transit#vehicles'
  get 'api/trolley' => 'miami_city_transit#proxy'

  get 'api/:endpoint' => 'miami_dade_transit#proxy'

  get 'trolley.:format' => 'trolley#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
