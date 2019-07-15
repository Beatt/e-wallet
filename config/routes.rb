Rails.application.routes.draw do
  scope module: 'api', path: 'api' do
    resources :customers, except: [:destroy] do
      resources :credit_cards
      resources :backs
      resources :transactions
    end
  end
end
