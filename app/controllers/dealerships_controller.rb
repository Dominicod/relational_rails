class DealershipsController < ApplicationController
  def new
  end

  def index
    @dealerships = Dealership.all.order(:created_at)
  end

  def show
    @dealership = Dealership.find(params[:id])
  end
end