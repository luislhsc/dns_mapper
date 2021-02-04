# UseCase module with a Single Responsibility of fetching DNS Records by a valid search
# Since our search use case is to render a response excluding any hostnames specified in the API call
# We remove the `included_hostnames` from the hostnames in our DnsRecords
class SearchDnsRecords
  PAGE_SIZE = 2

  def execute(valid_search)
    included_query = valid_search.included_hostnames.reduce(DnsRecord) do |query, included|
      filter_included_hostnames(query, included)
    end

    full_query = valid_search.excluded_hostnames.reduce(included_query) do |query, excluded|
      filter_excluded_hostnames(query, excluded)
    end

    records = full_query
      .order(id: :asc)
      .limit(PAGE_SIZE)
      # I know that use offset for pagination is bad, we can discuss other options in the interview
      # E.g. https://use-the-index-luke.com/blog/2013-07/pagination-done-the-postgresql-way
      .offset(PAGE_SIZE * (valid_search.page - 1))

    remove_included_hostnames(records, valid_search.included_hostnames)
  end

  private

    def remove_included_hostnames(records, included_hostnames)
      records.each do |record|
        included_hostnames.each { |hostname| record.hostnames.slice!(hostname) }
      end
    end

    def filter_included_hostnames(query, included_hostname)
      query.where('hostnames LIKE ?', "%#{included_hostname}%")
    end

    def filter_excluded_hostnames(query, excluded_hostname)
      query.where.not('hostnames LIKE ?', "%#{excluded_hostname}%")
    end
end
