Rails.application.routes.draw do

get "/stats", to: "shortened_urls#stats", as: :stats
get "shortened/:short_url", to: "shortened_urls#shortened", as: :shortened
post "/shortened_urls/create"
get "/:short_url", to: "shortened_urls#show"

root to: 'shortened_urls#index'
end
