json.array!(@api_listings) do |api_listing|
  json.extract! api_listing, :id
  json.url api_listing_url(api_listing, format: :json)
end
