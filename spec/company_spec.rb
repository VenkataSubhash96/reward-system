# frozen_string_literal: true
require File.expand_path './spec_helper.rb', __dir__

describe Company do
  let(:company) { described_class.new }

  describe '#invite_customer' do
    context 'when customer is not invited yet' do
      context 'when it is the first customer' do
        it 'adds the customer without any referrer' do
          company.invite_customer('Messi')

          expect(company.customers.first.name).to eq('Messi')
          expect(company.customers.first.referrer).to be_nil
        end
      end

      context 'when it is not first customer' do
        it 'adds the customer with referrer' do
          company.invite_customer('Messi', 'Ronaldo')

          expect(company.customers.first.name).to eq('Messi')
          expect(company.customers.first.referrer).to eq('Ronaldo')
        end
      end

      it 'adds the customer to the customers list' do
        company.invite_customer('Messi', 'Ronaldo')

        expect(company.customers.count).to eq(1)
      end
    end

    context 'when customer is already invited' do
      it 'does not invite the customer again' do
        company.invite_customer('Messi', 'Ronaldo')

        expect(company.invite_customer('Messi', 'Ronaldo')).to be_nil
      end
    end
  end

  describe '#find_customer' do
    it 'fetches the customer by name' do
      customer = company.invite_customer('Messi', 'Ronaldo')

      expect(company.find_customer('Messi')).to eq(customer)
    end
  end

  describe '#final_scores' do
    let(:expected_final_scores) do
      {
        'A' => 1.75,
        'B' => 1.5,
        'C' => 1.0
      }
    end

    it 'fetches the scores for each customer' do
      customer_a = company.invite_customer('A')
      customer_b = company.invite_customer('B', 'A')
      customer_b.accept_invitation!
      ScoreCalculator.new(company, customer_b).process
      customer_c = company.invite_customer('C', 'B')
      customer_c.accept_invitation!
      ScoreCalculator.new(company, customer_c).process
      customer_d = company.invite_customer('D', 'C')
      company.invite_customer('D', 'B')
      customer_d.accept_invitation!
      ScoreCalculator.new(company, customer_d).process

      expect(company.final_scores).to eq(expected_final_scores)
    end
  end
end
