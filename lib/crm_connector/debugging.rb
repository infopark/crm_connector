require 'logger'

module Infopark; module Crm
  module Debugging

    def logger
      self.class.logger
    end

    def self.included(base)
      base.logger ||= begin
        logger = Logger.new(STDERR)
        logger.progname = 'Infopark::Crm'
        logger.level = Logger::INFO
        logger
      end
    end

  end

end; end
