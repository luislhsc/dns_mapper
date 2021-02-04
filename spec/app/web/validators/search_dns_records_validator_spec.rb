require 'rails_helper'

RSpec.describe Validators::SearchDnsRecordsValidator do
  context 'validates params received from a request' do
    context 'when the params are valid' do
      it 'it returns a valid SearchDnsRecordsValidator object' do
        params = {
          'page' => 1,
          'included' => 'a.com,b.com',
          'excluded' => 'c.com,d.com,e.com'
        }

        result = described_class.new(params)

        expect(result.valid?).to eq(true)
        expect(result.included_hostnames.length).to eq(2)
        expect(result.excluded_hostnames.length).to eq(3)
      end
    end

    context 'when the params are invalid' do
      it 'it returns false when valid? is called' do
        params = {
          'page' => nil
        }

        expect { described_class.new(params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end
