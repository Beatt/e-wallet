Rails.application.routes.draw do
  root 'application#home'
  scope module: 'api', path: 'api' do
    resources :customers, except: [:destroy] do
      resources :credit_cards
      resources :backs
    end
  end
end
