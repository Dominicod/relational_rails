class DealershipVehiclesController < ApplicationController
  def new
    @dealer = Dealership.find(params[:id])
  end

  def index
    @dealer = Dealership.find(params[:id])

    if params[:_method] == "PATCH"
      @vehicles = @dealer.vehicles.where("cylinder_count > #{params[:threshold]}")
    else
      params[:alphabetical] == "alphabetical" ? @vehicles = @dealer.vehicles.order(:name) : @vehicles = @dealer.vehicles
    end
  end

  def create
    dealer = Dealership.find(params[:id])
    dealer.vehicles.create!(name: v_params[:name], cylinder_count: v_params[:cylinder_count],
                       horsepower: v_params[:horsepower], torque: v_params[:torque],
                       luxury_model: v_params[:luxury_model])

    redirect_to "/dealerships/#{dealer.id}/vehicles"
  end

  private
  def v_params
    {name: params[:vehicle][:name], cylinder_count: params[:vehicle][:cylinder_count],
     horsepower: params[:vehicle][:horsepower], torque: params[:vehicle][:torque],
     luxury_model: params[:vehicle][:luxury_model] ? true : false}
  end
end