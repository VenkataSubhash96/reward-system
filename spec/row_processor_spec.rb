# frozen_string_literal: true
require File.expand_path './spec_helper.rb', __dir__

describe RowProcessor do
  let(:company) { Company.new }

  describe '#process' do
    context 'with valid row' do
      context 'when action is recommends' do
        let(:row) { '2018-06-12 09:41 A recommends B' }

        it 'invites the customer' do
          expect(company).to receive(:invite_customer).twice

          described_class.new(row, company).process
        end
      end

      context 'when action is accepts' do
        let(:row) { '2018-06-14 09:41 B accepts' }

        it 'invites the customer' do
          customer = company.invite_customer('B')
          expect(customer).to receive(:accept_invitation!)

          described_class.new(row, company).process
        end
      end
    end

    context 'when invalid row' do
      let(:row) { 'Hello World!' }

      it 'logs error message' do
        expect_any_instance_of(Logger).to receive(:error).with('Invalid row')

        described_class.new(row, company).process
      end
    end
  end
end
