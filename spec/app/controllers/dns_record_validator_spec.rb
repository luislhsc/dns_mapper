require 'rails_helper'

RSpec.describe DnsRecordValidator do
  context 'validates params received from a request' do
    context 'when the params are valid' do
      it 'it returns a valid DnsRecordValidator object' do
        params = {
          'dns_records' => {
            'ip' => '1.1.1.1',
            'hostnames_attributes' => [
              {
                'hostname' => 'lorem.com'
              },
              {
                'hostname' => 'ipsum.com'
              }
            ]
          }
        }
        result = described_class.new(params)

        expect(result.valid?).to eq(true)
        expect(result.ip).to eq('1.1.1.1')
        expect(result.hostnames).to eq('lorem.com ipsum.com')
      end
    end

    context 'when the params are invalid' do
      it 'it returns false when valid? is called' do
        params = {
          'dns_records' => {
            'ip' => '2.2.2.2.2',
            'hostnames_attributes' => [
              {
                'hostname' => 'lorem.com'
              },
              {
                'hostname' => 'ipsum.com'
              }
            ]
          }
        }

        expect { described_class.new(params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end
