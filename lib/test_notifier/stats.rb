# frozen_string_literal: true

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

    private def normalize(options)
      %i[count success failures pending errors assertions]
        .each_with_object({}) do |key, buffer|
          buffer[key] = options[key].to_i
        end
    end

    private def status_for_rspec
      if options[:errors].nonzero?
        :error
      elsif options[:failures].nonzero?
        :fail
      else
        :success
      end
    end

    private def message_for_rspec
      options[:success] =
        options[:count] - (options[:failures] + options[:errors])

      text = []
      text << ("#{options[:count]} " + pluralize(options[:count], "example"))
      text << "#{options[:failures]} failed" unless options[:failures].zero?
      text << "#{options[:pending]} pending" unless options[:pending].zero?
      unless options[:errors].zero?
        text << ("#{options[:errors]} " + pluralize(options[:errors],
                                                    "error"))
      end
      text.join(", ")
    end

    private def status_for_minitest
      if options[:errors].nonzero?
        :error
      elsif options[:failures].nonzero?
        :fail
      else
        :success
      end
    end

    private def message_for_minitest
      text = []
      text << ("#{options[:count]} " + pluralize(options[:count], "test"))
      text << ("#{options[:assertions]} " + pluralize(options[:assertions],
                                                      "assertion"))
      text << "#{options[:failures]} failed" unless options[:failures].zero?

      unless options[:errors].zero?
        text << ("#{options[:errors]} " + pluralize(options[:errors],
                                                    "error"))
      end

      text << "#{options[:pending]} pending" unless options[:pending].zero?

      text.join(", ")
    end

    private def pluralize(count, text)
      count == 1 ? text : "#{text}s"
    end
  end
end
