require 'backports'

module Infopark; module Crm; module Core
  # Transparent wrapper for the web service's continuation ability
  class Enumerator < Enumerator
    def initialize(collection, continuation_handle, size, &block) #:nodoc:
      update(collection, continuation_handle, size)
      super &block
    end

    # The +continuation_handle+ parameter to be passed to the next find or search request for
    # programmatic paging
    def continuation_handle
      @continuation_handle
    end

    # The results of the last response as an array,
    # the array's size is less than or equal to the +limit+ parameter value
    def within_limit
      @collection
    end

    ##
    # :method: size
    # The total count given by the last search response, if available.
    # #size is undefined otherwise.
    ##

    #--
    # Note: We don't want size to return nil for compatibility for count's behavior
    #++
    def update(collection, continuation_handle, size) # :nodoc:
      @collection = collection
      @continuation_handle = continuation_handle
      @size = size
      define_singleton_method(:size) {@size} if @size
    end

    def inspect #:nodoc:
      "#{super.chop}, @within_limit=#{within_limit.inspect}" +
          ", @continuation_handle=#{continuation_handle.inspect}>"
    end

    private

    def rewind #:nodoc:
      raise NotImplementedError
    end
  end
end; end; end