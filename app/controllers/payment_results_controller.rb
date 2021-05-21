class PaymentResultsController < ApplicationController
  def index
    @payment_results = PaymentResult.filter_by_user(current_user)
  end
end
