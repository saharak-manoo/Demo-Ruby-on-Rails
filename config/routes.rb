Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#index'
  resources :homes

  resources :students

  resources :register_courses do
    member do
      get 'show_modal'
      get 'delete_subject'
      get 'restore_deletion'
    end

    collection do
      get 'all'
    end
  end

  resources :vacations do
    member do
      get 'show_modal'
    end

    collection do
      get 'calendar'
    end
  end

  resources :teachers do
    collection do
      get 'show_modal'
    end
  end

  resources :classrooms

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
