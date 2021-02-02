class DnsRecord < ApplicationRecord
  self.table_name = 'dns_records'

  attribute :ip, :string
  attribute :hostnames, :text

end
