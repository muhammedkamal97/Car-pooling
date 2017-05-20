class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  attr_accessor :nearlocation
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  def make_request 
    location = Location.find(params[:loc])
    create_notification (location)
    redirect_to current_user
  end

  def accept_request
    notification = Notification.find(params[:respond])
    notification.update(request: 'accept')
    notification.update(read: true)
    redirect_to current_user
  end

  def refuse_request
    notification = Notification.find(params[:respond])
    notification.update(request: 'refused')
    notification.update(read: true)
    redirect_to current_user
  end


  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit

  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @location.user_id = current_user.id
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        $checkTheLocation = 1
        redirect_to current_user
        return
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params[:heading]
      heading = params[:heading]
      head = Geocoder.coordinates(heading)
      starting = params[:starting]
      start = Geocoder.coordinates(starting)
      searchinglocation = Location.new
      geocoded = Geocoder.search(starting).first
        if geocoded
          searchinglocation.from_lat = geocoded.latitude
          searchinglocation.from_long = geocoded.longitude
        end
      geocoded = Geocoder.search(heading).first
        if geocoded
          searchinglocation.to_lat = geocoded.latitude
          searchinglocation.to_long = geocoded.longitude
        end
      @nearlocation = []

      for loc in Location.all
        locCOrdinates = Geocoder.coordinates(loc.fromAddress)
        dis = Geocoder::Calculations.distance_between(start, locCOrdinates, {:units => :km})
        if dis < 0.5
          @nearlocation << loc
        end
      end
      for loc in @nearlocation
        locCOrdinates = Geocoder.coordinates(loc.toAddress)
        dis = Geocoder::Calculations.distance_between(head, locCOrdinates, {:units => :km})
        if dis > 0.5
          @nearlocation.delete(loc)
        end
      end
      render :index
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:day, :fromAddress, :from_lat, 
                                       :from_long, :toAddress, :to_lat,
                                       :to_long, :time)
    end

    def create_notification (location)
        dr = location.user_id
        loc = location.id
        us = current_user
        Notification.create(user: us,
                            drive_user_id: dr,
                            location_id: loc,
                            request: 'pickup',
                            read: false)
    end
end
