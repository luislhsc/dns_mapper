# Serializer class to format the API response
module Serializers
  class DnsMatchSerializer
    def format(dns_records, hostnames_hash_count)
      {
        total_records: dns_records.count,
        records: format_records(dns_records),
        related_hostnames: format_hostnames(dns_records, hostnames_hash_count)
      }
    end

    private

      def format_records(dns_records)
        dns_records.map do |record|
          { id: record.id, ip_address: record.ip }
        end
      end

      def format_hostnames(dns_records, hostnames_hash_count)
        dns_records.map do |record|
          hostname = record.hostnames.split.first
          { hostname: hostname, count: hostnames_hash_count[hostname] }
        end
      end
  end
end
