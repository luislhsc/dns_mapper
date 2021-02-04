module Validators
  class DnsRecordValidator
    require 'resolv'

    include ActiveModel::Validations

    attr_reader :ip, :hostnames

    validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }
    validates :hostnames, presence: true

    def initialize(params)
      @ip = params['dns_records']['ip']
      @hostnames = join_hostnames(params['dns_records']['hostnames_attributes'])

      validate!
    end

    private

    def join_hostnames(hostnames_attributes)
      hostnames_attributes
        .map { |ha| ha['hostname'].downcase }
        .join(' ')
    end
  end
end
