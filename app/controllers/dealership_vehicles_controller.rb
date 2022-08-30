class DealershipVehiclesController < ApplicationController
  def new
    @dealer = Dealership.find(params[:id])
  end

  def index # move this to model
    @dealer = Dealership.find(params[:id])

    if params[:_method] == "patch"
      @vehicles = @dealer.vehicles.where("cylinder_count > #{params[:threshold]}")
    else
      params[:alphabetical] == "alphabetical" ? @vehicles = @dealer.vehicles.order(:name) : @vehicles = @dealer.vehicles
    end
  end

  def create
    dealer = Dealership.find(params[:id])
    dealer.vehicles.create!(vehicle_params)

    redirect_to "/dealerships/#{dealer.id}/vehicles"
  end
end