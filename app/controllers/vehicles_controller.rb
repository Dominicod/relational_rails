class VehiclesController < ApplicationController
  def new
  end

  def index
    @vehicles = Vehicle.all.where("luxury_model = true")
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def destroy
    Vehicle.destroy(params[:id])
    redirect_to "/vehicles"
  end

  def update
    vehicle = Vehicle.find(params[:id])
    vehicle.update(vehicle_params)

    redirect_to "/vehicles/#{vehicle.id}"
  end

  private # fix boolean
  def vehicle_params # convert boolean to a radio
    params.permit(:name, :cylinder_count, :horsepower, :torque, :luxury_model)
  end
end