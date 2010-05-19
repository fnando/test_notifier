module TestNotifier
  # create a .test_notifier at your home
  # directory and save the images as passed.png,
  # failure.png and error.png for custom images
  PASSED_IMAGE = "passed.png"
  FAILURE_IMAGE = "failure.png"
  ERROR_IMAGE = "error.png"
  FAILURE_TITLE = "FAILED"
  PASSED_TITLE = "Passed"

  RSPEC_REGEX = /(\d+) examples?, (\d+) failures?(, (\d+) pendings?)?/
  TEST_UNIT_REGEX = /(\d+)\stests,\s(\d+)\sassertions,\s(\d+)\sfailures,\s(\d+)\serrors/

  GROWL_REGISTER_FILE = File.expand_path("~/.test_notifier-growl")

  HELP_HINT = "For more information see:\n" +
             " * http://github.com/fnando/test_notifier (online)\n" +
             " * #{File.dirname(__FILE__)}/README.markdown (offline)"

  def self.notify(image, title, message)
    image ||= "none.png"

    custom_image = File.join(File.expand_path("~/.test_notifier"), image)
    image = File.exists?(custom_image) ? custom_image : File.join(File.dirname(__FILE__), "test_notifier", "icons", image)

    if RUBY_PLATFORM =~ /darwin/
      if `ps -Al | grep GrowlHelper` && `which growlnotify` && $? == 0
        unless File.file?(GROWL_REGISTER_FILE)
          script = File.dirname(__FILE__) + "/test_notifier/register-growl.scpt"
          system "osascript #{script} > #{GROWL_REGISTER_FILE}"
        end
        system "growlnotify -n test_notifier --image #{image} -p 2" +
               "-m \"#{message}\" -t \"#{title}\""
      else
        puts "No compatible popup notification system installed."
        puts "Try installing these:\n* Growl"
        puts HELP_HINT
      end
    elsif RUBY_PLATFORM =~ /mswin/
      begin
        require 'snarl'
      rescue LoadError
        puts 'To be notified by a popup please install Snarl and a ruby gem "ruby-snarl".'
        puts HELP_HINT
      else
        Snarl.show_message(title, message, image)
      end
    elsif RUBY_PLATFORM =~ /(linux|freebsd)/
      # if osd_cat is avaible
      if `which osd_cat` && $? == 0
        require 'test_notifier/osd_cat'
        color = case image
          when /#{PASSED_IMAGE}/
            'green'
          when /#{FAILURE_IMAGE}/
            'orange'
          when /#{ERROR_IMAGE}/
            'red'
        else
          'white'
        end
        OsdCat.send "#{title} \n #{message}", color
      # if dcop server is running
      elsif `ps -Al | grep dcop` && $? == 0
        def self.knotify title, message
          system "dcop knotify default notify " +
               "eventname \'#{title}\' \'#{message}\' '' '' 16 2"
        end
        knotify title, message
      # if kdialog is available
      elsif `which kdialog` && $? == 0
        system("kdialog --title #{title} --passivepopup \"#{message}\" 5")
      # if notify-send is avaible
      elsif `which notify-send` && $? == 0
        system "notify-send -i #{image} #{title} \"#{message}\""
      else
        puts "No popup notification software installed."
        puts "Try installing one of this:\n" +
             " * osd_cat (apt-get install xosd-bin),\n" +
             " * knotify (use KDE),\n" +
             " * kdialog (use KDE4),\n" +
             " * notify-send (apt-get install libnotify-bin)"
        puts HELP_HINT
      end
    end
  end

  def self.rspec?(content)
    (RSPEC_REGEX =~ content)
  end

  def self.notification_for_rspec(content)
    matches, *output = *content.to_s.match(RSPEC_REGEX)
    output = output.map {|i| i.to_i }
    e, f, none, p = output

    if f > 0
      # test has failed
      title = FAILURE_TITLE
      image = FAILURE_IMAGE
    elsif e > 0
      # everything's ok
      title = PASSED_TITLE
      image = PASSED_IMAGE
    else
      # no examples
      return
    end

    message = "#{e} examples, #{f} failures, #{p} pending"
    notify(image, title, message)
  end

  def self.notification_for_test_unit(content)
    matches, *output = *content.to_s.match(TEST_UNIT_REGEX)
    output = output.map {|i| i.to_i }
    t, a, f, e = output

    if f > 0 || e > 0
      # test has failed or raised an error
      title = FAILURE_TITLE
      image = e > 0 ? ERROR_IMAGE : FAILURE_IMAGE
    elsif a > 0
      # everything's ok
      title = PASSED_TITLE
      image = PASSED_IMAGE
    else
      # no assertions
      return
    end

    message = "#{t} tests, #{a} assertions, #{f} failures, #{e} errors"
    notify(image, title, message)
  end
end

