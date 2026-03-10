require "test_helper"

class CarTest < ActiveSupport::TestCase
  test "should create car with valid params including id" do
    car = Car.new(
      id: "550e8400-e29b-41d4-a716-446655440000",
      make: "Toyota",
      model: "Camry",
      year: 2025
    )
    assert car.save
  end

  test "should require id make model and year" do
    car = Car.new
    assert_not car.save
  end

  test "should require id from client" do
    car = Car.new(
      make: "Honda",
      model: "Civic",
      year: 2024
    )
    assert_not car.save
  end
end
