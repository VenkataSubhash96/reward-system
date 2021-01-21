# frozen_string_literal: true

class ScoreCalculator
  attr_reader :company, :customer

  def initialize(company, customer)
    @company = company
    @customer = customer
  end

  def process
    return 0.0 if customer.referrer.nil?

    0.step do |level|
      customer_referrer = customer.referrer
      break unless customer_referrer

      @customer = company.find_customer(customer_referrer)
      customer.score += score(level)
    end
    true
  end

  private

  def score(level)
    (1.0 / 2.0)**level.to_f
  end
end

