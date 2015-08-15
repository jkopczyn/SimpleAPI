json.type "FeatureCollection"
json.features do  
  json.array!(@listings) do |listing|
    json.type "Feature"
    json.geometry do 
      json.type "Point"
      json.coordinates do
        json.array! [listing.lat.to_f, listing.lng.to_f]
      end
    end
    json.properties do
      json.extract! listing, :id, :price, :street, :bedrooms, :bathrooms, :sq_ft
    end
  end
end
