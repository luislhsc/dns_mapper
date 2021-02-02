Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/rougting.html

  get '/dns', to: 'dns#get_words'

  get 'dns_records', to: 'dns#show'
  post 'dns_records', to: 'dns#create'
end
