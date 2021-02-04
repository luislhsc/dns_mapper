# UseCase module with a Single Responsibility of counting the hostnames
module UseCases
  class CountMatchingRecords
    def execute(dns_records)
      hash = Hash.new(0)

      all_hostnames = dns_records.map { |r| r.hostnames.split }.flatten
      hash_with_count = count_duplicated_records(hash, all_hostnames)

      { dns_records: dns_records, hostnames_count: hash_with_count }
    end

    private

      def count_duplicated_records(hash, hostnames)
        hostnames.each { |hostname| hash[hostname] += 1 }

        hash
      end
  end
end
