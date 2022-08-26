class DealershipsController < ApplicationController
  def new
  end

  def create
    name = params[:dealer][:name]
    lot_size = params[:dealer][:lot_size]
    service_center = params[:dealer][:service_center] ? true : false
    car_wash = params[:dealer][:car_wash] ? true : false
    Dealership.create!(name: name, vehicle_lot_size: lot_size, service_center: service_center, car_wash: car_wash)
    redirect_to "/dealerships"
  end

  def index
    @dealerships = Dealership.all.order(:created_at)
  end

  def show
    @dealership = Dealership.find(params[:id])
  end
end