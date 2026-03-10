class Car < ApplicationRecord
  validates :make, :model, :year, presence: true
end
