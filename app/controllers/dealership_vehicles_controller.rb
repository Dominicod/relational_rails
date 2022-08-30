class DealershipVehiclesController < ApplicationController
  def new
    @dealer = Dealership.find(params[:id])
  end

  def index
    @dealer = Dealership.find(params[:id])
    @vehicles = @dealer.vehicles

    if params[:sort] == "alphabetical"
      @vehicles = @dealer.alphabetical_vehicles
    elsif params[:sort] == "cylinder_threshold"
      @vehicles = @dealer.cylinder_threshold(params[:threshold])
    end
  end

  def create
    dealer = Dealership.find(params[:id])
    dealer.vehicles.create!(vehicle_params)

    redirect_to "/dealerships/#{dealer.id}/vehicles"
  end
end