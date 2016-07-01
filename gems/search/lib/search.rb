require 'active_support/dependencies'

ActiveSupport::Dependencies.autoload_paths += [__dir__]

require_dependency 'search/index'
require_dependency 'search/repository'
require_dependency 'search/token'
require_dependency 'search/engine' if defined?(Rails)

module Search
  class << self
    def repository
      Search::Repository.instance
    end

    delegate *Search::Repository.delegated, to: :repository

    def index!(record)
      searches_for_model(record.class).map do |search|
        search.index!(record)
      end
    end

    def delete!(record)
      searches_for_model(record.class).map do |search|
        search.delete!(record)
      end
    end
  end
end