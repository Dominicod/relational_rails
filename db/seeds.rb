# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vehicle.destroy_all
Dealership.destroy_all

dealer_1 = Dealership.create!(name: "Toyota", vehicle_lot_size: 10, service_center: true, car_wash: false)
dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)

dealer_1.vehicles.create!(name: "Supra", cylinder_count: 6, luxury_model: true, horsepower: 382, torque: 368)
dealer_1.vehicles.create!(name: "Rav-4", cylinder_count: 4, luxury_model: false, horsepower: 203, torque: 142)
dealer_2.vehicles.create!(name: "Mustang GT Fastback", cylinder_count: 8, luxury_model: false, horsepower: 450, torque: 410)
dealer_2.vehicles.create!(name: "Ford GT", cylinder_count: 6, luxury_model: true, horsepower: 660, torque: 634)
dealer_3.vehicles.create!(name: "GTR", cylinder_count: 6, luxury_model: true, horsepower: 600, torque: 481)