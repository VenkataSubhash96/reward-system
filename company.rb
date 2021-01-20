# frozen_string_literal: true

class Company
  attr_reader :customers

  def initialize
    @customers = []
  end

  def invite_customer(referrer, name)
    logger.error("Customer already invited - #{name}") && return if customer_already_invited?(name)

    customer = Customer.new(name, referrer)
    @customers.push(customer)
    customer
  end

  def find_customer(name)
    customers.find { |customer| customer.name == name }
  end

  def final_scores
    customers.map do |customer|
      {
        customer.name => customer.score
      }
    end.inject(:merge)
  end

  private

  def customer_already_invited?(name)
    customers.any? { |customer| customer.name == name }
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
