class DealershipsController < ApplicationController
  def new
  end

  def index
    @dealerships = Dealership.all
  end

  def show
    @dealership = Dealership.find(params[:id])
  end
end