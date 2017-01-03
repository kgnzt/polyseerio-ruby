require 'logger'

# Introduces a logger into the main module.
module Polyseerio
  class << self
    attr_writer :logger

    # Convert a string log level to a severity.
    def level_to_severity(level) # rubocop:disable all
      case level
      when 'debug'
        Logger::DEBUG
      when 'error'
        Logger::ERROR
      when 'fatal'
        Logger::FATAL
      when 'info'
        Logger::INFO
      when 'unknown'
        Logger::UNKNOWN
      when 'warn'
        Logger::WARN
      else
        raise ArgumentError, "Unsupported log level: #{level}."
      end
    end

    # Gem logger.
    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.level = if ENV.key? 'POLYSEERIO_LOG_LEVEL'
                      level_to_severity ENV['POLYSEERIO_LOG_LEVEL']
                    else
                      Logger::ERROR
                    end

        log.progname = name
      end
    end

    # Convenience logging method.
    def log(severity, *args)
      severity = if severity.is_a? String
                   level_to_severity severity
                 else
                   severity
                 end

      logger.log(severity, *args)
    end
  end
end
