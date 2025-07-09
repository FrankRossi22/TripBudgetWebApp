class Expense < ApplicationRecord
    belongs_to :trip
    belongs_to :paid_by, class_name: 'Person', foreign_key: 'paid_by_id'
    has_many :expense_assignments, dependent: :destroy
    has_many :people, through: :expense_assignments

    validates :Amount, presence: true, numericality: { greater_than: 0 }
    validates :description, presence: true
    validates :paid_by, presence: true
    validates :people, presence: true, if: :split_payment?
    validates :date, presence: true
    validates :currency, presence: true

    accepts_nested_attributes_for :expense_assignments, allow_destroy: true

    attr_accessor :split_payment

    def split_payment?
        split_payment == '1'
    end

    def split_amount
        return 0 if people.empty?
        amount_in_usd / people.count
    end
    
    before_validation :set_default_currency

    CONVERSION_RATES = {
    'USD' => 1.0,
    'CAD' => 0.75,
    'EUR' => 1.2,
    'GBP' => 1.4
  }

    def amount_in_usd

        self.Amount * CONVERSION_RATES[currency]
      end

private

def set_default_currency
  self.currency ||= 'USD'
end

end
