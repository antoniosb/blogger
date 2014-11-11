Blogger::Application.routes.draw do
  root to: 'articles#index'
  resources :articles do
    resources :comments
  end
  resources :tags
  resources :authors
  resources :author_sessions, only: [:new, :create, :destroy]
  get 'login' => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
  get 'articles_by_month' => 'articles#by_month'
  get 'popular_articles' => 'articles#popular'
  get 'rss' => 'articles#feed'
end
