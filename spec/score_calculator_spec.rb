# frozen_string_literal: true
require File.expand_path './spec_helper.rb', __dir__

describe ScoreCalculator do
  let(:company) { Company.new }

  describe '#process' do
    context 'when customer referrer is nil' do
      it 'returns 0.0' do
        customer = company.invite_customer('Messi')
        expect(described_class.new(company, customer).process).to eq(0.0)
      end
    end

    context 'when level one' do
      it 'updates the score of first referrer to 1.0' do
        customer_messi = company.invite_customer('Messi')
        customer_ronaldo = company.invite_customer('Ronaldo', 'Messi')

        expect { described_class.new(company, customer_ronaldo).process }
          .to change { customer_messi.score }.from(0.0).to(1.0)
      end
    end

    context 'when level two' do
      it 'updates the score of first referrer to 1.5' do
        customer_messi = company.invite_customer('Messi')
        customer_ronaldo = company.invite_customer('Ronaldo', 'Messi')
        described_class.new(company, customer_ronaldo).process
        customer_hazard = company.invite_customer('Hazard', 'Ronaldo')

        expect { described_class.new(company, customer_hazard).process }
          .to change { customer_messi.score }.from(1.0).to(1.5)
      end

      it 'updates the score of second referrer to 1.0' do
        customer_messi = company.invite_customer('Messi')
        customer_ronaldo = company.invite_customer('Ronaldo', 'Messi')
        described_class.new(company, customer_ronaldo).process
        customer_hazard = company.invite_customer('Hazard', 'Ronaldo')

        expect { described_class.new(company, customer_hazard).process }
          .to change { customer_ronaldo.score }.from(0.0).to(1.0)
      end
    end
  end
end
