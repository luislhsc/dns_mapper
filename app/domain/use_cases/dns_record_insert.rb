# Class that handles DNS inserts/updates
module UseCases
  class DnsRecordInsert
    def execute(valid_dns_record)
      record = Models::DnsRecord.find_by(ip: valid_dns_record.ip)

      if record
        record.update(hostnames: valid_dns_record.hostnames)
        record
      else
        Models::DnsRecord.create(ip: valid_dns_record.ip, hostnames: valid_dns_record.hostnames)
      end
    end
  end
end
