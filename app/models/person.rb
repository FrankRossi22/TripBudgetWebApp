# app/models/person.rb
class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :trips, through: :participations

  has_many :expense_assignments, dependent: :destroy
  has_many :expenses, through: :expense_assignments  # Expenses this person is responsible for

  validates :name, presence: true, length: { minimum: 3 }
  # Remove email validation as Devise handles it
  # validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def net_balance(trip)
    # Get all expenses for this trip where the person paid
    paid_expenses = trip.expenses.where(paid_by_id: id)
    total_paid = paid_expenses.sum{ |expense| expense.amount_in_usd }

    # Calculate total amount this person owes
    total_owed = 0
    trip.expenses.includes(:people).each do |expense|
      if expense.people.any?
        # If expense is split, add their share
        if expense.people.include?(self)
          total_owed += expense.split_amount
        end
      else
        # If expense is not split and they paid it, they are responsible for all of it
        if expense.paid_by_id == id
          total_owed += expense.Amount
        end
      end
    end

    # Net balance is what they paid minus what they owe
    total_paid - total_owed
  end
end
