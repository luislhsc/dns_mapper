class SearchDnsRecordsValidator
  require 'resolv'

  include ActiveModel::Validations

  attr_reader :included_hostnames, :excluded_hostnames, :page

  validates :page, presence: true, allow_blank: false

  def initialize(params)
    @page = params['page']
    @included_hostnames = split_words(params['included'])
    @excluded_hostnames = split_words(params['excluded'])
    validate!
  end

  private

  def split_words(words)
    if words
      words.split(',')
    else
      []
    end
  end
end
