Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'preorder#index'

  match '/preorder'        => 'preorder#index', :via => [:get, :post]
  get 'preorder/checkout'
  match 'preorder/share/:uuid' => 'preorder#share', :via => :get
  match '/preorder/prefill' => 'preorder#prefill', :via => [:get, :post]
end
