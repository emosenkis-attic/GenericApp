class ListingsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show, :mobiledownload, :mobileupload]
  attr_accessor :title, :descr, :url
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.find(:all, conditions: 'approved = 1', order: 'created_at DESC') || []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end

  def mobiledownload
    @listings = Listing.find(:all, conditions: 'approved = 1', order: 'created_at DESC') || []
    render json: @listings, callback: params[:callback]
  end

  def mobileupload
    @user=User.find_by_email(params[:email])
    if @user.nil?
      render json: {error: 'User not found'}, callback: params[:callback]
    else
      @listing = @user.listings.new(title: params[:title], descr: params[:descr], url: params[:url])
      if @listing.save
        render json: @listing, callback: params[:callback]
      else
        render json: {error: 'Failed to create listing'}, callback: params[:callback]
      end
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find_by_id(params[:id])
    if @listing.nil? || (@listing.approved != 1 && (@current_user.nil? || @listing.user_id != @current_user.id))
      redirect_to listings_path
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @listing }
      end
    end
  end

  # GET /listings/new
  # GET /listings/new.json
  def new
    @listing = Listing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = @current_user.listings.new(params[:listing])
    @listing.approved = 1

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render json: @listing, status: :created, location: @listing }
      else
        format.html { render action: "new" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /listings/1
  # PUT /listings/1.json
  def update
    @listing = Listing.find(params[:id])
    redirect_to @listing unless @current_user.id == @listing.user_id

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end
end
