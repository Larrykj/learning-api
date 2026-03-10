class CarDetail < ApplicationRecord
     validates :id, :make, :model, :year, presence: true
end
