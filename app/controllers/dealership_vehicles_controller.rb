class DealershipVehiclesController < ApplicationController
  def new
    @dealer = find_dealer
  end

  def index
    @dealership = find_dealer
  end

  def create
    dealer = find_dealer
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

  def find_dealer
    Dealership.find(params[:id])
  end
end