module TestNotifier
  module Notifier
    module Knotify
      extend self

      def supported?
        RUBY_PLATFORM =~ /(linux|freebsd)/ && `ps -Al | grep dcop` && $? == 0
      end

      def notify(options)
        Thread.new do
          `dcop knotify default notify eventname \'#{options[:title]}\' \'#{options[:message]}\' '' '' 16 2`
        end
      end
    end
  end
end
