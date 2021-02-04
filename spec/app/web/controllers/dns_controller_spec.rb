require 'rails_helper'

RSpec.describe Controllers::DnsController, type: :request do
  context 'when receive a GET request in /dns_records' do
    context 'when the params are valid' do
      it 'it correctly returns the matched IPs and count' do
        first_dns = create_records('1.1.1.1', 'lorem.com ipsum.com dolor.com amet.com')
        create_records('2.2.2.2', 'ipsum.com')
        third_dns = create_records('3.3.3.3', 'ipsum.com dolor.com amet.com')
        create_records('4.4.4.4', 'ipsum.com dolor.com sit.com amet.com')
        create_records('5.5.5.5', 'dolor.com sit.com')
        params = 'page=1&included=ipsum.com, dolor.com&excluded=sit.com'

        get "/dns_records?#{params}"

        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body['total_records']).to eq(2)
        expect(body['records'][0]['ip_address']).to eq(first_dns.ip)
        expect(body['records'][1]['ip_address']).to eq(third_dns.ip)
      end

      it 'it correctly returns the matched hostnames and count' do
        create_records('1.1.1.1', 'lorem.com ipsum.com dolor.com amet.com')
        create_records('2.2.2.2', 'ipsum.com')
        create_records('3.3.3.3', 'ipsum.com dolor.com amet.com')
        create_records('4.4.4.4', 'ipsum.com dolor.com sit.com amet.com')
        create_records('5.5.5.5', 'dolor.com sit.com')
        params = 'page=1&included=ipsum.com, dolor.com&excluded=sit.com'

        get "/dns_records?#{params}"

        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body['related_hostnames'][0]['hostname']).to eq('lorem.com')
        expect(body['related_hostnames'][0]['count']).to eq(1)
        expect(body['related_hostnames'][1]['hostname']).to eq('amet.com')
        expect(body['related_hostnames'][1]['count']).to eq(2)
      end
    end

    context 'when there is no match' do
      it 'it returns empty result' do
        create_records('1.1.1.1', 'lorem.com ipsum.com dolor.com amet.com')
        params = 'page=1&included=ipsum.com&excluded=dolor.com'

        get "/dns_records?#{params}"

        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body['total_records']).to eq(0)
        expect(body['records']).to be_empty
        expect(body['related_hostnames']).to be_empty
      end
    end
  end

  context 'when receive a POST request in /dns_records' do
    context 'when the IP is new' do
      it 'persists the IP and the related Hostnames' do
        params = {
          dns_records: {
            ip: '1.1.1.1',
            hostnames_attributes: [{ hostname: 'lorem.com' }, { hostname: 'dolor.com' }]
          }
        }

        post '/dns_records', params: params

        body = JSON.parse(response.body)
        expect(response.status).to eq(201)
        expect(body['id']).to eq(Models::DnsRecord.first.id)
      end
    end

    context 'when the IP already exists in DB' do
      it 'updates the IP with new Hostnames' do
        create_records('1.1.1.1', 'dolor.com')
        params = {
          dns_records: {
            ip: '1.1.1.1',
            hostnames_attributes: [{ hostname: 'ipsum.com' }, { hostname: 'amet.com' }]
          }
        }

        post '/dns_records', params: params

        body = JSON.parse(response.body)
        inserted_hostname = Models::DnsRecord.first
        expect(response.status).to eq(201)
        expect(body['id']).to eq(inserted_hostname.id)
        expect(inserted_hostname.hostnames).to eq('ipsum.com amet.com')
      end
    end
  end

  def create_records(ip, hostnames)
    Models::DnsRecord.create(ip: ip, hostnames: hostnames)
  end
end
