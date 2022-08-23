class VehiclesController < ApplicationController
  def new
  end

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end
end