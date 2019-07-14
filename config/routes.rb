Rails.application.routes.draw do
  scope module: 'api', path: 'api' do
    resources :customers do
      resources :credit_cards
      resources :backs
      resources :transactions
    end
  end
end
