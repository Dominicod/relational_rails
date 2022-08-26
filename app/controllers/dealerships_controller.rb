class DealershipsController < ApplicationController
  def new
  end

  def create
    Dealership.create!(name: d_params[:name], vehicle_lot_size: d_params[:lot_size],
                       service_center: d_params[:service_center], car_wash: d_params[:car_wash])
    redirect_to "/dealerships"
  end

  def index
    @dealerships = Dealership.all.order(:created_at)
  end

  def show
    @dealership = Dealership.find(params[:id])
  end

  def edit
    @dealer = show
  end

  def update
    task = show
    task.update(name: d_params[:name], vehicle_lot_size: d_params[:lot_size],
                service_center: d_params[:service_center], car_wash: d_params[:car_wash])
    redirect_to "/dealerships/#{task.id}"
  end

  def d_params
    {name: params[:dealer][:name], lot_size: params[:dealer][:lot_size],
     service_center: params[:dealer][:service_center] ? true : false,
     car_wash: params[:dealer][:car_wash] ? true : false}
  end
end