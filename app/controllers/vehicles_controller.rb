class VehiclesController < ApplicationController
  def new
  end

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    vehicle = Vehicle.find(params[:id])
    vehicle.update(name: v_params[:name], cylinder_count: v_params[:cylinder_count],
      horsepower: v_params[:horsepower], torque: v_params[:torque],
      luxury_model: v_params[:luxury_model])

    redirect_to "/vehicles/#{vehicle.id}"
  end

  private

  def v_params
    {name: params[:vehicle][:name], cylinder_count: params[:vehicle][:cylinder_count],
     horsepower: params[:vehicle][:horsepower], torque: params[:vehicle][:torque],
     luxury_model: params[:vehicle][:luxury_model] ? true : false}
  end
end