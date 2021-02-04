module Controllers
  class DnsController < Controllers::ApplicationController
    def search_dns_records
      valid_search = Validators::SearchDnsRecordsValidator.new(params)
      dns_results = UseCases::SearchDnsRecords.new.execute(valid_search)
      dns_and_count = UseCases::CountMatchingRecords.new.execute(dns_results)
      response = Serializers::DnsMatchSerializer.new.format(dns_and_count[:dns_records], dns_and_count[:hostnames_count])

      render json: response
    end

    def create
      valid_record = Validators::DnsRecordValidator.new(params)
      inserted_record = UseCases::DnsRecordInsert.new.execute(valid_record)

      render json: { id: inserted_record.id }, status: 201
    end
  end
end
