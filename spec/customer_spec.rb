# frozen_string_literal: true
require File.expand_path './spec_helper.rb', __dir__

describe Customer do
  describe '#accept_invitation!' do
    let(:customer) { described_class.new('Ronaldo', referrer: 'Messi') }

    it 'sets score as 0.0' do
      expect(customer.score).to eq(0.0)
    end

    it 'sets referrer as Messi' do
      expect(customer.referrer).to eq('Messi')
    end

    it 'sets invitation_accepted as false' do
      expect(customer.invitation_accepted).to be_falsey
    end

    it 'sets accept_invitation value as true' do
      customer.accept_invitation!

      expect(customer.invitation_accepted).to be_truthy
    end
  end
end
