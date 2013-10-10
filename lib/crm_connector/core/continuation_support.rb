module Infopark; module Crm; module Core

  # @private
  module ContinuationSupport
    def self.included(klass)
      klass.extend(ClassMethods)
      klass.has_continuation
    end

    module ClassMethods
      def has_continuation
        class << self
          def find_every(options)
            get_with_continuation(nil, options)
          end

          private

          def get_with_continuation(prefix, options)
            prefix_options, query_options = split_options(options[:params])
            path = collection_path(prefix_options, query_options)
            response = prefix ? get(prefix, query_options) : connection.get(path, headers)
            response = format.decode(response.body) unless response.kind_of? Hash
            response = {'results' => response} if response.kind_of? Array # fighting ActiveResource 3.1 magic
            collection = instantiate_collection(response['results'] || [], prefix_options)
            result = Core::Enumerator.new(collection, response['continuation_handle'], response['total']) { |yielder|
              loop do
                result.within_limit.each {|entity| yielder.yield entity}
                break if result.continuation_handle.nil?
                # get next page
                query_options[:continuation_handle] = result.continuation_handle
                path = collection_path(prefix_options, query_options)
                response = prefix ? get(prefix, query_options) : connection.get(path, headers)
                response = format.decode(response.body) unless response.kind_of? Hash
                response = {'results' => response} if response.kind_of? Array # fighting ActiveResource 3.1 magic
                collection = instantiate_collection(response['results'] || [], prefix_options)
                result.update(collection, response['continuation_handle'], response['total'])
              end
            }
          end
        end
      end
    end
  end
end; end; end
