class DnsController < ApplicationController
  def show
    valid_search = SearchDnsRecordsValidator.new(params)
    dns_results = SearchDnsRecords.new.execute(valid_search)
    dns_and_count = CountMatchingRecords.new.execute(dns_results)
    response = DnsMatchSerializer.new.format(dns_and_count[:dns_records], dns_and_count[:hostnames_count])

    render json: response
  end

  def create
    valid_record = DnsRecordValidator.new(params)
    inserted_record = DnsRecordInsert.new(valid_record)

    render json: inserted_record
  end
end
