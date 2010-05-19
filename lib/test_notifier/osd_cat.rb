# Provides a method for popup notifications using osd_cat
# Extracted from http://theadmin.org/articles/2008/2/10/fail-loudly-with-osd_cat-and-autotest
module OsdCat
  # Use xlsfonts to find the different fonts
  FONT = "-bitstream-charter-bold-r-normal--33-240-100-100-p-206-iso8859-1"

  # Will display the message on the top of the screen centered, adjust these numbers to suit.
  POSITION = "top"             # top|middle|bottom
  POSITION_OFFSET = "0"         # Pixels from position to display (think CSS margin)
  ALIGN = "center"             # left|right|center

  def self.send message, color='green'
    osd_command = "echo #{message.inspect} | osd_cat --font=#{FONT} --shadow=0 --pos=#{POSITION} -o #{POSITION_OFFSET} --delay=4 --outline=4 --align=#{ALIGN} -c #{color}"

    # osd_cat blocks so start a new thread, otherwise Autotest will wait
    Thread.new do
      `#{osd_command}`
    end
  end
end