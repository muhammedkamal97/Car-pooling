class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
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
    redirect_to current_user
  end

  def refuse_request
    notification = Notification.find(params[:respond])
    notification.update(request: 'refused')
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
