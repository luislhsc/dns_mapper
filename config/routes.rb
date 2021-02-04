Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/rougting.html

    #get '/dns', to: 'controllers.dns#get_words'
    #get 'dns_records', to: 'controllers.dns#show'
    #post 'dns_records', to: 'dns#create'

  scope module: :controllers do
    get 'dns_records', to: 'dns#search_dns_records'
    post 'dns_records', to: 'dns#create'
  end
end
