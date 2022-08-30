class ApplicationController < ActionController::Base
  private
  def dealer_params
    params.permit(:name, :vehicle_lot_size, :service_center, :car_wash)
  end

  def vehicle_params
    params.permit(:name, :cylinder_count, :horsepower, :torque, :luxury_model)
  end
end
