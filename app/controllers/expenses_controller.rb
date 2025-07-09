class ExpensesController < ApplicationController
  before_action :set_trip
  before_action :set_expense, only: %i[ show edit update destroy ]

  # GET /trips/:trip_id/expenses
  def index
    @expenses = @trip.expenses.includes(:paid_by, :people)
  end

  # GET /trips/:trip_id/expenses/1
  def show
  end

  # GET /trips/:trip_id/expenses/new
  def new
    @expense = @trip.expenses.build
    @available_people = @trip.people.order(:name)
  end

  # GET /trips/:trip_id/expenses/1/edit
  def edit
    @available_people = @trip.people.order(:name)
    @expense.split_payment = '1' if @expense.people.any?
  end

  # POST /trips/:trip_id/expenses
  def create
    @expense = @trip.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to trip_expenses_path(@trip), notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: [@trip, @expense] }
      else
        @available_people = @trip.people.order(:name)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/:trip_id/expenses/1
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to trip_expenses_path(@trip), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: [@trip, @expense] }
      else
        @available_people = @trip.people.order(:name)
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/:trip_id/expenses/1
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to trip_expenses_path(@trip), notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def set_expense
      @expense = @trip.expenses.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:Amount, :category, :description, :currency, :paid_by_id, :split_payment, :date, person_ids: [])
    end
end
