class DealershipsController < ApplicationController
  def new
  end

  def create
    Dealership.create!(dealer_params)

    redirect_to "/dealerships"
  end

  def destroy
    Dealership.destroy(params[:id])
    redirect_to "/dealerships"
  end

  def index
    @dealerships = Dealership.all.order(:created_at)
  end

  def show
    @dealership = Dealership.find(params[:id])
  end

  def edit
    @dealer = Dealership.find(params[:id])
  end

  def update
    dealer = Dealership.find(params[:id])
    dealer.update(dealer_params)

    redirect_to "/dealerships/#{dealer.id}"
  end
end