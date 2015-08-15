json.type "FeatureCollection"
json.features do  
  json.array!(@listings) do |listing|
    json.type "feature"
    json.geometry do 
      json.type "Point"
      json.coordinates do
        json.array! [listing.lat, listing.lng]
      end
    end
    json.properties do
      json.extract! listing, :id, :price, :street, :bedrooms, :bathrooms, :sq_ft
    end
  end
end
