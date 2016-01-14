Rails.application.routes.draw do
  #using collection to deal with many tasks
  #takes a new action completed in controller, and http request (:get) to get info
  #takes a new action complete in controller, and http request (:put) to updating model
  resources :tasks, :except => [:show] do
    put 'completed', on: :collection      #this gives us a new route
  end

  root 'tasks#index'

end
