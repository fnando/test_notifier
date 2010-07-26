module TestNotifier
  class << self
    attr_accessor :__notifier
  end

  IMAGES = {
    :fail    => File.dirname(__FILE__) + "/../resources/fail.png",
    :error   => File.dirname(__FILE__) + "/../resources/error.png",
    :success => File.dirname(__FILE__) + "/../resources/success.png"
  }

  TITLES = {
    :fail    => "Failed!",
    :success => "Passed!"
  }

  def self.notify(options)
    options.merge!({
      :title => TITLES[options[:status]],
      :image => IMAGES[options[:status]]
    })

    notifier.notify(options)
  end

  def self.notifier
    self.__notifier ||= begin
      TestNotifier::Notifier.constants.sort.collect do |const|
        self.__notifier = TestNotifier::Notifier.const_get(const)
        break if self.__notifier.supported?
      end

      self.__notifier
    end
  end

  autoload :Notifier, "test_notifier/notifier"
  autoload :Runner,   "test_notifier/runner"
end
