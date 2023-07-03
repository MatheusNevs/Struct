Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope 'api' do
    scope 'posts' do
      get '', to: 'posts#index'
      get ':id', to: 'posts#show'
      post 'create', to: 'posts#create'
      patch 'update/:id', to: 'posts#update'
      delete 'delete/:id', to: 'posts#delete'
    end

    scope 'categories' do
      get '', to: 'categories#index'
      get ':id', to: 'categories#show'
      post 'create', to: 'categories#create'
      patch 'update/:id', to: 'categories#update'
      delete 'delete/:id', to: 'categories#delete'
    end
    
    scope 'feedbacks' do
      get '', to: 'feedbacks#index'
      get ':id', to: 'feedbacks#show'
      post 'create', to: 'feedbacks#create'
      patch 'update/:id', to: 'feedbacks#update'
      delete 'delete/:id', to: 'feedbacks#delete'
    end
    
    scope 'comments' do
      get '', to: 'comments#index'
      get ':id', to: 'comments#show'
      post 'create', to: 'comments#create'
      patch 'update/:id', to: 'comments#update'
      delete 'delete/:id', to: 'comments#delete'
    end

    scope 'users' do
      get 'login', to: 'users#login'
      get '', to: 'users#index'
      get ':email', to: 'users#show'
      post 'create', to: 'users#create'
      patch 'update/:email', to: 'users#update'
      delete 'delete/:email', to: 'users#delete'
    end
  end
end