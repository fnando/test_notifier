test_notifier
=============

* [http://github.com/fnando/test_notifier](http://github.com/fnando/test_notifier)

DESCRIPTION:
------------

Inspired by 
http://railstips.org/2007/7/23/autotest-growl-pass-fail-notifications

After using Growl notification, I decided to write my own plugin because I have
to work on Ubuntu and Mac OS X and I missed the notification on my Linux box. 
This plugin works with Linux, Mac OS X and Windows. All you need to do is 
install the specific notification library for your OS.

Instead of displaying lots of notifications for each failure, I prefer to be 
notified about the whole test result (you'll have to check your log 
file anyway in order to clean up the failures/errors).

INSTALLATION:
-------------

###Mac OS X

1) Install Growl (http://growl.info/)
2) Install the growlnotify script located on the "Extras" directory
3) Open the Growl Preference Page (System > Growl) and activate the
options "Listen for incoming notifications" and "Allow remote 
application registration" on the Network tab.

###Linux

1) Install libnotify-bin ant its dependencies:
	
	aptitude install libnotify-bin

###Windows

1) Install Snarl: download from http://www.fullphat.net/
2) Install ruby-snarl:

	gem install ruby-snarl

###All

Then, install the gem:

	git clone git://github.com/fnando/test_notifier.git
	cd test_notifier
	rake gem:install

or

	sudo gem install fnando-test_notifier --source=http://gems.github.com

USAGE:
------

If you're using Test::Unit you should add `require "test_notifier/test_unit"`
If you're using RSpec you should add `require "test_notifier/rspec"`
If you're using Autotest you should add `require "test_notifier/autotest"` to
the file `~/.autotest`

If you want to customize the images, create a directory at `~/.test_notifier`
and save the images `none.png`, `passed.png`, `failure.png` and `error.png`.

MAINTAINER
----------
 
* Nando Vieira ([http://simplesideias.com.br](http://simplesideias.com.br))

LICENSE:
--------

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.