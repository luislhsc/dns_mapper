module UseCase
  module DnsRecordInsert
    module_function

    def call(valid_dns_record)
      record = DnsRecord.find_by(ip: valid_dns_record.ip)

      if record
        record.update(hostnames: valid_dns_record.hostnames)
        record
      else
        DnsRecord.create(ip: valid_dns_record.ip, hostnames: valid_dns_record.hostnames)
      end
    end
  end
end
