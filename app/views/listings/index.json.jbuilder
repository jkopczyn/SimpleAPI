json.array!(@listings) do |listing|
  json.extract! listing, :id, :street, :status, :price, :bedrooms, :bathrooms, :sq_ft, :lat, :lng
  json.url listing_url(listing, format: :json)
end
