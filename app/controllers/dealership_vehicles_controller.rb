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

  private
  def vehicle_params # convert boolean to a radio
    params.permit(:name, :cylinder_count, :horsepower, :torque, :luxury_model)
  end
  # def v_params
  #   {name: params[:vehicle][:name], cylinder_count: params[:vehicle][:cylinder_count],
  #    horsepower: params[:vehicle][:horsepower], torque: params[:vehicle][:torque],
  #    luxury_model: params[:vehicle][:luxury_model] ? true : false}
  # end
end