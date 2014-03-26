module Infopark; module Crm; module Core
  # Transparent wrapper for the web services continuation ability
  class Enumerator < Enumerator

    # @private
    def initialize(collection, continuation_handle, size, &block)
      update(collection, continuation_handle, size)
      super &block
    end

    ##
    # The +continuation_handle+ parameter to be passed to the next find or search request for
    # programmatic paging.
    # @return [String]
    # @private
    def continuation_handle
      @continuation_handle
    end

    ##
    # The results of the last response as an array.
    # The size of the array is less than or equal to the +limit+ parameter value.
    # @return [Array]
    def within_limit
      @collection
    end

    ##
    # @!method size
    # The total count given by the last search response, if available.
    # If not available this method is undefiend.
    # @return [Integer] The total count given by the last search response, if available.
    ##

    ##
    # Note: We don't want size to return nil for compatibility for count's behavior
    # @private
    def update(collection, continuation_handle, size)
      @collection = collection
      @continuation_handle = continuation_handle
      @size = size
      define_singleton_method(:size) {@size} if @size
    end

    # @private
    def inspect
      "#{super.chop}, @within_limit=#{within_limit.inspect}" +
          ", @continuation_handle=#{continuation_handle.inspect}>"
    end

    private

    def rewind #:nodoc:
      raise NotImplementedError
    end
  end
end; end; end