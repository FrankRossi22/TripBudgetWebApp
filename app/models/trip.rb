# app/models/trip.rb
class Trip < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :people, through: :participations

  has_many :expenses, dependent: :destroy

  validates :destination, presence: true
  validates :Start_Date, presence: true
  validates :End_Date, presence: true
  validates :name, presence: true

  accepts_nested_attributes_for :participations, allow_destroy: true

  def calculate_settlements
    # Get all balances
    balances = {}
    people.each do |person|
      balances[person] = person.net_balance(self)
    end

    # Separate into creditors (positive balance) and debtors (negative balance)
    creditors = balances.select { |_, balance| balance > 0 }
    debtors = balances.select { |_, balance| balance < 0 }

    # Initialize settlements array
    settlements = []

    # Keep going until all debts are settled
    while debtors.any? && creditors.any?
      debtor, debt = debtors.min_by { |_, amount| amount }  # Person who owes the most
      creditor, credit = creditors.max_by { |_, amount| amount }  # Person who is owed the most

      # Calculate the transfer amount
      amount = [debt.abs, credit].min
      
      # Add the settlement
      settlements << {
        from: debtor,
        to: creditor,
        amount: amount
      }

      # Update balances
      debtors[debtor] += amount
      creditors[creditor] -= amount

      # Remove settled parties
      debtors.delete(debtor) if debtors[debtor].abs < 0.01
      creditors.delete(creditor) if creditors[creditor] < 0.01
    end

    settlements
  end
end
