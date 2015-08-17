class Api::ListingsController < ApplicationController

  before_action :set_api_listing, only: [:show, :edit, :update, :destroy]

  # GET /api/listings
  # GET /api/listings.json

  def index
    #@page = params[:page] ? params[:page] : 1
    args = listing_params
    args ||= {}
    @listings = paginate Listing.where(*query_args(args))
    
    render :index
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    LISTING_FIELDS = [ :id, :street, :status, :price, :bedrooms, :bathrooms, :sq_ft, :lat, :lng]
    LISTING_MINS = [ :min_price, :min_bed, :min_bath ]
    LISTING_MAXS = [ :max_price, :max_bed, :max_bath]
    LISTING_NUMERICS = [:price, :bedrooms, :bathrooms]
    LISTING_QUERY_PARAMS = LISTING_MINS + LISTING_MAXS
    def listing_params
      params.permit(*(LISTING_FIELDS + LISTING_QUERY_PARAMS))
    end

    def arg_parser(arg)
      { 
        min_bath: "bathrooms >= :min_bath",
        max_bath: "bathrooms <= :max_bath",
        min_bed: "bedrooms >= :min_bed",
        max_bed: "bedrooms <= :max_bed",
        min_price: "price >= :min_price",
        max_price: "price <= :max_price",
      }[arg]
    end

    def query_args(query_hash)
      #this takes the intersection of the two sets to ensure safety
      mins = query_hash.keys.map(&:to_sym) & LISTING_MINS
      maxs = query_hash.keys.map(&:to_sym) & LISTING_MAXS
      [(mins + maxs).map { |arg| arg_parser(arg) }.join(" and "), query_hash]
    end

end
