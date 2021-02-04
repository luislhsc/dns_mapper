Rails.application.routes.draw do
  scope module: :controllers do
    get 'dns_records', to: 'dns#search_dns_records'
    post 'dns_records', to: 'dns#create'
  end
end
