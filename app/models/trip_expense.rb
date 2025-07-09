class TripExpense < ApplicationRecord
  belongs_to :trip
  belongs_to :expense
end
