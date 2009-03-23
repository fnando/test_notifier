require 'snarl' if RUBY_PLATFORM =~ /mswin/

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
  
  def self.notify(image, title, message)
    image ||= "none.png"
    
    custom_image = File.join(File.expand_path("~/.test_notifier"), image)
    image = File.exists?(custom_image) ? custom_image : File.join(File.dirname(__FILE__), "test_notifier", "icons", image)

    if RUBY_PLATFORM =~ /darwin/
      system("growlnotify -n test_notifier --image #{image} -p 2 -m \"#{message}\" -t \"#{title}\"")
    elsif RUBY_PLATFORM =~ /mswin/
      Snarl.show_message(title, message, image)
    elsif RUBY_PLATFORM =~ /(linux|freebsd)/
      # if osd_cat is avaible
      if `which osd_cat` && $? == 0
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
        def self.knotify title, msg
          system "dcop knotify default notify " +
               "eventname \'#{title}\' \'#{msg}\' '' '' 16 2"
        end
        knotify title, message
      # if notify-send is avaible
      elsif `which notify-send` && $? == 0
        system("notify-send -i #{image} #{title} \"#{message}\"")
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

# Provides a method for popup notifications using osd_cat
# Extracted from http://theadmin.org/articles/2008/2/10/fail-loudly-with-osd_cat-and-autotest
module OsdCat
  # TODO move this module to a separate file

  # Use xlsfonts to find the different fonts
  FONT = "-bitstream-charter-bold-r-normal--33-240-100-100-p-206-iso8859-1"

  # Will display the message on the top of the screen centered, adjust these numbers to suit.
  POSITION = "top"             # top|middle|bottom
  POSITION_OFFSET = "0"         # Pixels from position to display (think CSS margin)
  ALIGN = "center"             # left|right|center

  def self.send msg, color='green'
    osd_command = "echo #{msg.inspect} | osd_cat --font=#{FONT} --shadow=0 --pos=#{POSITION} -o #{POSITION_OFFSET} --delay=4 --outline=4 --align=#{ALIGN} -c #{color}"

    # osd_cat blocks so start a new thread, otherwise Autotest will wait
    Thread.new do
      `#{osd_command}`
    end
  end
end