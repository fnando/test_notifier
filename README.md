# Test Notifier

Inspired by
http://railstips.org/2007/7/23/autotest-growl-pass-fail-notifications

After using Growl notification, I decided to write my own plugin because I have
to work on Ubuntu and Mac OS X and I missed the notification on my Linux box.
This plugin works with Linux, Mac OS X and Windows. All you need to do is
install the specific notification library for your OS.

Instead of displaying lots of notifications for each failure, I prefer to be
notified about the whole test result (you'll have to check your log file anyway
in order to clean up the failures/errors).

## Installation

```
gem install test_notifier
```

Check <https://github.com/fnando/notifier> to see how you can configure a
notifier for your OS.

## Usage

If you're using Test::Unit you should add
`require "test_notifier/runner/test_unit"` to your `test_helper.rb` file.

If you're using RSpec you should add `require "test_notifier/runner/spec"` to
your `spec_helper.rb` file. If you're using RSpec 2-3, you need to add
`require "test_notifier/runner/rspec"` instead.

If you're using Autotest you should add
`require "test_notifier/runner/autotest"` to the file `~/.autotest`

If you're using MiniTest you should add
`require "test_notifier/runner/minitest"` to your `test_helper.rb` file.

You can define your notifier.

```ruby
TestNotifier.default_notifier = :growl
```

The available notifiers are `:growl`, `:kdialog`, `:knotify`, `:notify_send`,
`:osd_cat`, and `:snarl`.

If you'd like to make Test Notifier optional for your project:

```ruby
TestNotifier.silence_no_notifier_warning = true
```

## Maintainer

- Nando Vieira - https://nandovieira.com

## Collaborators

https://github.com/fnando/test_notifier/graphs/contributors

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
