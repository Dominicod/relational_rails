class DealershipVehiclesController < ApplicationController
  def index
    @dealership = Dealership.find(params[:id])
  end
end