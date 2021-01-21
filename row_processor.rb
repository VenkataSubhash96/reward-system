# frozen_string_literal: true

class RowProcessor
  module Actions
    RECOMMENDS = 'recommends'
    ACCEPTS = 'accepts'

    ALL = [RECOMMENDS, ACCEPTS].freeze
  end

  attr_reader :row, :company

  def initialize(row, company)
    @row = row.split(' ')
    @company = company
  end

  def process
    unless action_whitelisted?
      log_error(invalid_action_error)
      return
    end

    recommend_action? ? invite_customer : accept_invitation
  end

  private

  def invite_customer
    customer = company.find_customer(customer_name)
    company.invite_customer(customer_name) if customer.nil?
    company.invite_customer(invitee_name, customer_name)
  end

  def accept_invitation
    customer = company.find_customer(customer_name)
    return log_error(unknown_customer_error) if customer.nil?

    customer.accept_invitation!
    ScoreCalculator.new(company, customer).process
  end

  def action_whitelisted?
    Actions::ALL.include?(action)
  end

  def log_error(message)
    logger.error(message)
  end

  def invalid_action_error
    'Invalid row'
  end

  def unknown_customer_error
    "Unknown Customer - #{customer_name}"
  end

  def recommend_action?
    action == Actions::RECOMMENDS
  end

  def accept_action?
    action == Actions::ACCEPTS
  end

  def customer_name
    @customer_name ||= row[2]
  end

  def action
    @action ||= row[3]
  end

  def invitee_name
    @invitee_name ||= row[4]
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
