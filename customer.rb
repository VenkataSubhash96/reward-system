# frozen_string_literal: true

class Customer
  attr_accessor :name, :referrer, :score
  attr_reader :invitation_accepted

  def initialize(name, referrer:)
    @name = name
    @referrer = referrer
    @invitation_accepted = false
    @score = 0.0
  end

  def accept_invitation!
    @invitation_accepted = true
  end
end
