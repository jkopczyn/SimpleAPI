class Api::ListingsController < ApplicationController

  before_action :set_api_listing, only: [:show, :edit, :update, :destroy]

  # GET /api/listings
  # GET /api/listings.json
  def index
    @listings = Listing.all
  end

  def index
    #@page = params[:page] ? params[:page] : 1
    args = listing_params
    args ||= {}
    @listings = paginate Listing.where(*query_args(args))
    
    render :index
  end


  # GET /api/listings/1
  # GET /api/listings/1.json
  def show
  end

  ## POST /api/listings
  ## POST /api/listings.json
  #def create
  #  @listing = Listing.new(api_listing_params)

  #  respond_to do |format|
  #    if @listing.save
  #      format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
  #      format.json { render :show, status: :created, location: @listing }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @listing.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## PATCH/PUT /api/listings/1
  ## PATCH/PUT /api/listings/1.json
  #def update
  #  respond_to do |format|
  #    if @listing.update(api_listing_params)
  #      format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @listing }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @listing.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## DELETE /api/listings/1
  ## DELETE /api/listings/1.json
  #def destroy
  #  @listing.destroy
  #  respond_to do |format|
  #    format.html { redirect_to api_listings_url, notice: 'Listing was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

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

    def arg_parser(arg, value)
      { 
        min_bath: "bathrooms >= #{value}",
        max_bath: "bathrooms <= #{value}",
        min_bed: "bedrooms >= #{value}",
        max_bed: "bedrooms <= #{value}",
        min_price: "price >= #{value}",
        max_price: "price <= #{value}",
      }[arg]
    end

    def query_args(query_hash)
      #this takes the intersection of the two sets to ensure safety
      mins = query_hash.keys.map(&:to_sym) & LISTING_MINS
      maxs = query_hash.keys.map(&:to_sym) & LISTING_MAXS
      [(mins + maxs).map { |arg| arg_parser(arg, query_hash[arg]) }.join(" and ")]
    end

end
