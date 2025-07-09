json.extract! expense, :id, :Amount, :People, :trip_id, :created_at, :updated_at, :currency
json.url expense_url(expense, format: :json)
