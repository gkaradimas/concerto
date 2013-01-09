class ActiveSupport::BufferedLogger
  def formatter=(formatter)
    @log.formatter = formatter
  end
end

class ScrubbingFormatter < Logger::Formatter
  def scrub_file_data input
    input.gsub(/\["file_data", ".*, \["file_name/, '["file_data", "REDACTED"], ["file_name')
  end

  def call(severity, timestamp, progname, msg)
    "#{scrub_file_data msg}\n"
  end
end

Rails.logger.formatter = ScrubbingFormatter.new