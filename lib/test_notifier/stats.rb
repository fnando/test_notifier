module TestNotifier
  class Stats
    attr_accessor :adapter, :options

    def initialize(adapter, options = {})
      @adapter = adapter
      @options = normalize(options)
    end

    def status
      @options = normalize(options)
      send("status_for_#{adapter}")
    end

    def message
      @options = normalize(options)
      send("message_for_#{adapter}")
    end

    private
    def normalize(options)
      [:total, :success, :fail, :pending, :errors, :assertions].inject({}) do |buffer, key|
        buffer[key] = options[key].to_i
        buffer
      end
    end

    def status_for_test_unit
      if options[:errors].nonzero?
        :error
      elsif options[:fail].nonzero?
        :fail
      else
        :success
      end
    end

    def status_for_rspec
      if options[:errors].nonzero?
        :error
      elsif options[:fail].nonzero?
        :fail
      else
        :success
      end
    end

    def status_for_spec
      if options[:fail].nonzero?
        :fail
      else
        :success
      end
    end

    def message_for_rspec
      options[:success] = options[:total] - options[:fail]
      options[:fail] =  options[:fail] - options[:errors]

      text = []
      text << "#{options[:total]} " + pluralize(options[:total], "example")
      text << "#{options[:fail]} failed" unless options[:fail].zero?
      text << "#{options[:pending]} pending" unless options[:pending].zero?
      text << "#{options[:errors]} " + pluralize(options[:errors], "error") unless options[:errors].zero?
      text.join(", ")
    end

    def message_for_spec
      text = []
      text << "#{options[:total]} " + pluralize(options[:total], "example")
      text << "#{options[:fail]} failed" unless options[:fail].zero?
      text << "#{options[:pending]} pending" unless options[:pending].zero?
      text.join(", ")
    end

    def message_for_test_unit
      text = []
      text << "#{options[:total]} " + pluralize(options[:total], "test")
      text << "#{options[:assertions]} " + pluralize(options[:assertions], "assertion")
      text << "#{options[:fail]} failed" unless options[:fail].zero?
      text << "#{options[:errors]} " + pluralize(options[:errors], "error") unless options[:errors].zero?
      text.join(", ")
    end

    def pluralize(count, text)
      count > 1 ? "#{text}s" : text
    end
  end
end
