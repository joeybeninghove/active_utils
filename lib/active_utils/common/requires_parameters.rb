module ActiveMerchant #:nodoc:
  module RequiresParameters #:nodoc:
    def requires!(hash, *params)
      missing_params = []

      params.each do |param|
        if param.is_a?(Array)
          raise ArgumentError.new("Missing required parameter: #{param.first}") unless hash.has_key?(param.first)

          valid_options = param[1..-1]
          raise ArgumentError.new("Parameter: #{param.first} must be one of #{valid_options.to_sentence(:words_connector => 'or')}") unless valid_options.include?(hash[param.first])
        else
          missing_params << param unless hash.has_key?(param)
        end
      end

      raise MissingParamsError.new(missing_params) if missing_params.any?
    end
  end
end
