class ExpenseAssignment < ApplicationRecord
  belongs_to :person
  belongs_to :expense
end
